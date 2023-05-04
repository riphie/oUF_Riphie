local A, L = ...

-- Up-value used global functions
local unpack = unpack

-- PostUpdate: callback function called after the health has been updated.
local function PostUpdate(self, unit, min, max)
  if self.colorThreat and self.colorThreatInvers and unit and UnitThreatSituation("player", unit) == 3 then
    self:SetStatusBarColor(unpack(L.C.colors.healthbar.threatInvers))
    self.bg:SetVertexColor(unpack(L.C.colors.healthbar.threatInversBG))
  elseif self.colorThreat and unit and UnitThreatSituation(unit) == 3 then
    self:SetStatusBarColor(unpack(L.C.colors.healthbar.threat))
    self.bg:SetVertexColor(unpack(L.C.colors.healthbar.threatBG))
  end
end

-- PostUpdateColor: callback function called after the health color has been
-- updated.
local function PostUpdateColor(self, unit)
  local npcID = tonumber(strmatch((UnitGUID(unit) or ""), "%-(%d-)%-%x-$"))
  local customUnit = L.C.customUnits and L.C.customUnits[npcID]

  local tap = UnitIsTapDenied(unit) and not UnitPlayerControlled(unit)

  local player = UnitIsPlayer(unit)
  local class = select(2, UnitClass(unit))
  local ccolor = oUF.colors.class[class] or 1, 1, 1

  local status = UnitThreatSituation("player", unit) or false
  local tcolor = oUF.colors.threat[status] or 1, 1, 1

  local reaction = UnitReaction(unit, "player")
  local rcolor = oUF.colors.reaction[reaction] or 1, 1, 1

  local r, g, b

  if customUnit then
    r, g, b = unpack(customUnit)
  elseif player and (reaction and reaction >= 5) then
    r, g, b = unpack(ccolor)
  elseif player and (reaction and reaction <= 4) then
    r, g, b = unpack(ccolor)
  elseif tap then
    r, g, b = 0.3, 0.3, 0.3
  elseif status then
    r, g, b = unpack(tcolor)
  else
    r, g, b = unpack(rcolor)
  end

  if r or g or b then
    self:SetStatusBarColor(r, g, b)
    self.bg:SetVertexColor(r * 0.3, g * 0.3, b * 0.3)
  end
end
L.F.UpdateNameplateColor = UpdateNameplateColor

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

  if self.settings.template == "nameplate" then
    healthbar.PostUpdateColor = PostUpdateColor
  else
    healthbar.PostUpdate = PostUpdate
  end

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
