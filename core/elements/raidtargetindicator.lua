local A, L = ...

local function CreateRaidTargetIndicator(self)
  if not self.cfg.raidicon or not self.cfg.raidicon.enabled then
    return
  end

  return L.F.CreateIcon(self.Health, "OVERLAY", -8, self.cfg.raidicon.size, self.cfg.raidicon.point)
end
L.F.CreateRaidTargetIndicator = CreateRaidTargetIndicator
