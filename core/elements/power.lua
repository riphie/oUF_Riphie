local A, L = ...

local unpack = unpack

local function CreatePowerBar(self)
  if not self.cfg.powerbar or not self.cfg.powerbar.enabled then
    return
  end

  local powerbar = CreateFrame("StatusBar", nil, self)
  powerbar:SetStatusBarTexture(L.C.textures.statusbar)
  powerbar:SetSize(unpack(self.cfg.powerbar.size))
  L.F.SetPoint(powerbar, self, self.cfg.powerbar.point)

  local bg = powerbar:CreateTexture(nil, "BACKGROUND")
  bg:SetTexture(L.C.textures.statusbarBG)
  bg:SetAllPoints()
  powerbar.bg = bg

  L.F.CreateBackdrop(powerbar)

  powerbar.colorPower = self.cfg.powerbar.colorPower
  powerbar.bg.multiplier = L.C.colors.bgMultiplier

  return powerbar
end
L.F.CreatePowerBar = CreatePowerBar

local function CreatePowerText(self)
  if not self.cfg.powerbar or not self.cfg.powerbar.power or not self.cfg.powerbar.power.enabled then
    return
  end

  local cfg = self.cfg.powerbar.power
  local text = L.F.CreateText(self.Power, cfg.font, cfg.size, cfg.outline, cfg.align, cfg.noshadow)

  if cfg.points then
    SetPoints(text, self.Power, cfg.points)
  else
    SetPoint(text, self.Power, cfg.point)
  end

  self:Tag(text, cfg.tag)
end
L.F.CreatePowerText = CreatePowerText
