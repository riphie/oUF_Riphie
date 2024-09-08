local _, L = ...

-- CreateStyle: create the full unit frame.
local function CreateStyle(self)
  L.F.SetupFrame(self)
  L.F.SetupHeader(self)

  self.Range = self.cfg.range

  self.Health = L.F.CreateHealthBar(self)
  L.F.CreateHealthText(self)
  L.F.CreateHealthPercText(self)
  self.HealthPrediction = L.F.CreateHealthPrediction(self)
  self.Name = L.F.CreateNameText(self)

  self.Power = L.F.CreatePowerBar(self)
  L.F.CreatePowerText(self)

  self.Castbar = L.F.CreateCastBar(self)

  self.Debuffs = L.F.CreateDebuffs(self)
  self.Buffs = L.F.CreateBuffs(self)

  self.RaidTargetIndicator = L.F.CreateRaidTargetIndicator(self)
  self.ReadyCheckIndicator = L.F.CreateReadyCheckIndicator(self)
  self.SummonIndicator = L.F.CreateSummonIndicator(self)
end
L.F.CreateStyle = CreateStyle
