local A, L = ...

local unpack = unpack

local function ColorHealthbarOnThreat(self, unit)
  if self.colorThreat and self.colorThreatInvers and unit and UnitThreatSituation("player", unit) == 3 then
    self:SetStatusBarColor(unpack(L.C.colors.healthbar.threatInvers))
    self.bg:SetVertexColor(unpack(L.C.colors.healthbar.threatInversBG))
  elseif self.colorThreat and unit and UnitThreatSituation(unit) == 3 then
    self:SetStatusBarColor(unpack(L.C.colors.healthbar.threat))
    self.bg:SetVertexColor(unpack(L.C.colors.healthbar.threatBG))
  end
end

local function PostUpdateHealth(self, unit, min, max)
  ColorHealthbarOnThreat(self, unit)
end

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

  healthbar.colorTapping = self.cfg.healthbar.colorTapping
  healthbar.colorDisconnected = self.cfg.healthbar.colorDisconnected
  healthbar.colorReaction = self.cfg.healthbar.colorReaction
  healthbar.colorClass = self.cfg.healthbar.colorClass
  healthbar.colorHealth = self.cfg.healthbar.colorHealth
  healthbar.colorThreat = self.cfg.healthbar.colorThreat
  healthbar.colorThreatInvers = self.cfg.healthbar.colorThreatInvers
  healthbar.bg.multiplier = L.C.colors.bgMultiplier
  healthbar.frequentUpdates = self.cfg.healthbar.frequentUpdates

  healthbar.PostUpdate = PostUpdateHealth

  return healthbar
end
L.F.CreateHealthBar = CreateHealthBar

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
