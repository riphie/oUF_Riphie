local A, L = ...

local function CreateStyle(self)
  L.F.SetupFrame(self)
  L.F.SetupHeader(self)

  self.Health = L.F.CreateHealthBar(self)
  self.HealthPrediction = L.F.CreateHealthPrediction(self)
  L.F.CreateHealthText(self)
  L.F.CreateHealthPercText(self)
  self.Name = L.F.CreateNameText(self)

  self.Power = L.F.CreatePowerBar(self)
  L.F.CreatePowerText(self)

  self.Castbar = L.F.CreateCastBar(self)

  self.Debuffs = L.F.CreateDebuffs(self)
  self.Buffs = L.F.CreateBuffs(self)

  self.RaidTargetIndicator = L.F.CreateRaidTargetIndicator(self)

  if self.settings.template == "raid" or self.settings.template == "party" then
    self.Range = { insideAlpha = 1, outsideAlpha = 0.5 }
    self.ReadyCheckIndicator = L.F.CreateReadyCheckIndicator(self)
  end
end
L.F.CreateStyle = CreateStyle
