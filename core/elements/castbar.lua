local A, L = ...

local unpack = unpack

-- PostCastStart: callback function called after a cast or channel has started.
local function PostCastStart(self, unit)
  if self.notInterruptible then
    self:SetStatusBarColor(unpack(L.C.colors.castbar.shielded))
    self.bg:SetVertexColor(unpack(L.C.colors.castbar.shieldedBG))
  else
    self:SetStatusBarColor(unpack(L.C.colors.castbar.default))
    self.bg:SetVertexColor(unpack(L.C.colors.castbar.defaultBG))
  end
end

-- CustomTimeText: callback function called to set the format of the cast time
-- text.
local function CustomTimeText(self, duration)
  if self.Time then
    self.Time:SetText(("%.1f / %.1f"):format(self.channeling and duration or duration, self.max))
  end
end

-- CreateCastBar: create a castbar frame.
local function CreateCastBar(self)
  if not self.cfg.castbar or not self.cfg.castbar.enabled then
    return
  end

  local castbar = CreateFrame("StatusBar", nil, self)
  castbar:SetStatusBarTexture(L.C.textures.statusbar)
  castbar:SetFrameStrata "MEDIUM"
  L.F.SetSize(castbar, unpack(self.cfg.castbar.size))
  L.F.SetPoint(castbar, self, self.cfg.castbar.point)
  castbar:SetStatusBarColor(unpack(L.C.colors.castbar.default))

  local bg = castbar:CreateTexture(nil, "BACKGROUND")
  bg:SetTexture(L.C.textures.statusbar)
  bg:SetAllPoints()
  bg:SetVertexColor(unpack(L.C.colors.castbar.defaultBG))
  castbar.bg = bg

  L.F.CreateBackdrop(castbar)

  if self.cfg.castbar.icon and self.cfg.castbar.icon.enabled then
    local i = castbar:CreateTexture(nil, "BACKGROUND", nil, -8)
    L.F.SetSize(i, unpack(self.cfg.castbar.icon.size))
    L.F.SetPoint(i, castbar, self.cfg.castbar.icon.point)

    if self.cfg.castbar.icon.texCoord then
      i:SetTexCoord(unpack(self.cfg.castbar.icon.texCoord))
    else
      i:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    end

    castbar.Icon = i

    L.F.CreateBackdrop(castbar, i)
  end

  if self.cfg.castbar.name and self.cfg.castbar.name.enabled then
    local cfg = self.cfg.castbar.name
    local name = L.F.CreateText(castbar, cfg.font, cfg.size, cfg.outline, cfg.align, cfg.noshadow)

    if cfg.points then
      L.F.SetPoints(name, castbar, cfg.points)
    else
      L.F.SetPoint(name, castbar, cfg.point)
    end

    castbar.Text = name
  end

  if self.cfg.castbar.time and self.cfg.castbar.time.enabled then
    local cfg = self.cfg.castbar.time
    local time = L.F.CreateText(castbar, cfg.font, cfg.size, cfg.outline, cfg.align, cfg.noshadow)

    if cfg.points then
      L.F.SetPoints(time, castbar, cfg.points)
    else
      L.F.SetPoint(time, castbar, cfg.point)
    end

    castbar.Time = time
  end

  if self.cfg.castbar.safezone and self.cfg.castbar.safezone.enabled then
    local safezone = castbar:CreateTexture(nil, "OVERLAY")
    safezone:SetVertexColor(0.5, 1, 1)
    castbar.SafeZone = safezone
  end

  castbar.PostCastStart = PostCastStart
  castbar.CustomTimeText = CustomTimeText

  return castbar
end
L.F.CreateCastBar = CreateCastBar
