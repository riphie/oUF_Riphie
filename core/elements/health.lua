local A, L = ...

-- Up-value used global functions
local unpack = unpack

-- ColorHealthbarOnThreat: color the healthbar based on the units threat.
local function ColorHealthbarOnThreat(self, unit)
  if self.colorThreat and self.colorThreatInvers and unit and UnitThreatSituation("player", unit) == 3 then
    self:SetStatusBarColor(unpack(L.C.colors.healthbar.threatInvers))
    self.bg:SetVertexColor(unpack(L.C.colors.healthbar.threatInversBG))
  elseif self.colorThreat and unit and UnitThreatSituation(unit) == 3 then
    self:SetStatusBarColor(unpack(L.C.colors.healthbar.threat))
    self.bg:SetVertexColor(unpack(L.C.colors.healthbar.threatBG))
  end
end

-- PostUpdateHealth: callback function called after the health has been updated.
local function PostUpdateHealth(self, unit, min, max)
  ColorHealthbarOnThreat(self, unit)
end

-- CreateHealthBar: create a healthbar frame.
local function CreateHealthBar(self)
  local healthbar = CreateFrame("StatusBar", nil, self)
  healthbar:SetStatusBarTexture(L.C.textures.statusbar)
  healthbar:SetAllPoints()

  if L.C.colors.healthbar and L.C.colors.healthbar.default then
    healthbar:SetStatusBarColor(unpack(L.C.colors.healthbar.default))
  end

  local bg = healthbar:CreateTexture(nil, "BACKGROUND")
  bg:SetTexture(L.C.textures.statusbarBG)
  bg:SetAllPoints()

  if L.C.colors.healthbar and L.C.colors.healthbar.defaultBG then
    bg:SetVertexColor(unpack(L.C.colors.healthbar.defaultBG))
  end

  healthbar.bg = bg

  L.F.CreateBackdrop(healthbar)

  healthbar.colorDisconnected = self.cfg.healthbar.colorDisconnected
  healthbar.colorThreat = self.cfg.healthbar.colorThreat
  healthbar.colorThreatInvers = self.cfg.healthbar.colorThreatInvers
  healthbar.colorClass = self.cfg.healthbar.colorClass
  healthbar.colorReaction = self.cfg.healthbar.colorReaction
  healthbar.colorHealth = self.cfg.healthbar.colorHealth

  healthbar.frequentUpdates = self.cfg.healthbar.frequentUpdates

  healthbar.bg.multiplier = L.C.colors.bgMultiplier

  healthbar.PostUpdateColor = self.cfg.healthbar.PostUpdateColor or PostUpdateHealth

  return healthbar
end
L.F.CreateHealthBar = CreateHealthBar

-- CreateHealthText: create text for the health.
local function CreateHealthText(self)
  if not self.cfg.healthbar or not self.cfg.healthbar.health or not self.cfg.healthbar.health.enabled then
    return
  end

  local cfg = self.cfg.healthbar.health
  local text = L.F.CreateText(self.Health, cfg.font, cfg.size, cfg.outline, cfg.align, cfg.noshadow)

  if cfg.points then
    L.F.SetPoints(text, self.Health, cfg.points)
  else
    L.F.SetPoint(text, self.Health, cfg.point)
  end

  self:Tag(text, cfg.tag)
end
L.F.CreateHealthText = CreateHealthText

-- CreateHealthPercText: create text for the health percentage.
local function CreateHealthPercText(self)
  if not self.cfg.healthbar or not self.cfg.healthbar.healthperc or not self.cfg.healthbar.healthperc.enabled then
    return
  end

  local cfg = self.cfg.healthbar.healthperc
  local text = L.F.CreateText(self.Health, cfg.font, cfg.size, cfg.outline, cfg.align, cfg.noshadow)

  if cfg.points then
    L.F.SetPoints(text, self.Health, cfg.points)
  else
    L.F.SetPoint(text, self.Health, cfg.point)
  end

  self:Tag(text, cfg.tag)
end
L.F.CreateHealthPercText = CreateHealthPercText

-- CreateHealthPrediction: create frames for health predictions.
local function CreateHealthPrediction(self)
  if not self.cfg.absorbbar or not self.cfg.absorbbar.enabled then
    return
  end

  local myBar = CreateFrame("StatusBar", nil, self.Health)
  myBar:SetPoint("TOP")
  myBar:SetPoint("BOTTOM")
  myBar:SetPoint("LEFT", self.Health:GetStatusBarTexture(), "RIGHT")
  myBar:SetWidth(200)
  myBar:SetStatusBarTexture(L.C.textures.statusbar)
  myBar:SetStatusBarColor(unpack(L.C.colors.healthbar.own))

  local otherBar = CreateFrame("StatusBar", nil, self.Health)
  otherBar:SetPoint("TOP")
  otherBar:SetPoint("BOTTOM")
  otherBar:SetPoint("LEFT", self.Health:GetStatusBarTexture(), "RIGHT")
  otherBar:SetWidth(200)
  otherBar:SetStatusBarTexture(L.C.textures.statusbar)
  otherBar:SetStatusBarColor(unpack(L.C.colors.healthbar.other))

  local absorbBar = CreateFrame("StatusBar", nil, self.Health)
  absorbBar:SetPoint("TOP")
  absorbBar:SetPoint("BOTTOM")
  absorbBar:SetPoint("LEFT", self.Health:GetStatusBarTexture(), "RIGHT")
  absorbBar:SetWidth(200)
  absorbBar:SetStatusBarTexture(L.C.textures.absorb)
  absorbBar:SetStatusBarColor(unpack(L.C.colors.healthbar.absorb))

  local healAbsorbBar = CreateFrame("StatusBar", nil, self.Health)
  healAbsorbBar:SetPoint("TOP")
  healAbsorbBar:SetPoint("BOTTOM")
  healAbsorbBar:SetPoint("RIGHT", self.Health:GetStatusBarTexture())
  healAbsorbBar:SetWidth(200)
  healAbsorbBar:SetStatusBarTexture(L.C.textures.absorb)
  healAbsorbBar:SetReverseFill(true)

  local overAbsorb = self.Health:CreateTexture(nil, "OVERLAY")
  overAbsorb:SetPoint("TOP")
  overAbsorb:SetPoint("BOTTOM")
  overAbsorb:SetPoint("LEFT", self.Health, "RIGHT")
  overAbsorb:SetWidth(10)

  local overHealAbsorb = self.Health:CreateTexture(nil, "OVERLAY")
  overHealAbsorb:SetPoint("TOP")
  overHealAbsorb:SetPoint("BOTTOM")
  overHealAbsorb:SetPoint("RIGHT", self.Health, "LEFT")
  overHealAbsorb:SetWidth(10)

  return {
    myBar = myBar,
    otherBar = otherBar,
    absorbBar = absorbBar,
    healAbsorbBar = healAbsorbBar,
    overAbsorb = overAbsorb,
    overHealAbsorb = overHealAbsorb,
    maxOverflow = 1.05,
  }
end
L.F.CreateHealthPrediction = CreateHealthPrediction
