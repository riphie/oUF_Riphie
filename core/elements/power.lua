local A, L = ...

-- Up-value used global functions
local unpack = unpack

-- CreatePowerBar: create a powerbar frame.
local function CreatePowerBar(self)
  if not self.cfg.powerbar or not self.cfg.powerbar.enabled then
    return
  end

  local powerbar = CreateFrame("StatusBar", nil, self)
  powerbar:SetStatusBarTexture(L.C.textures.statusbar)
  L.F.SetSize(powerbar, unpack(self.cfg.powerbar.size))
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

-- CreatePowerText: create text for the power.
local function CreatePowerText(self)
  if not self.cfg.powerbar or not self.cfg.powerbar.power or not self.cfg.powerbar.power.enabled then
    return
  end

  local cfg = self.cfg.powerbar.power
  local text = L.F.CreateText(self.Power, cfg.font, cfg.size, cfg.outline, cfg.align, cfg.noshadow)

  if cfg.points then
    L.F.SetPoints(text, self.Power, cfg.points)
  else
    L.F.SetPoint(text, self.Power, cfg.point)
  end

  self:Tag(text, cfg.tag)
end
L.F.CreatePowerText = CreatePowerText
