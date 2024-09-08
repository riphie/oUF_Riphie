local _, L = ...

-- CreateSummonIndicator: create a summon indicator icon.
local function CreateSummonIndicator(self)
  if not self.cfg.summonindicator or not self.cfg.summonindicator.enabled then
    return
  end

  return L.F.CreateIcon(self.Health, "OVERLAY", nil, self.cfg.summonindicator.size, self.cfg.summonindicator.point)
end
L.F.CreateSummonIndicator = CreateSummonIndicator
