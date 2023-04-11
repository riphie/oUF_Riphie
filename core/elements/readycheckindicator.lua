local A, L = ...

-- CreateReadyCheckIndicator: create a ready check indicator icon.t
local function CreateReadyCheckIndicator(self)
  if not self.cfg.readycheck or not self.cfg.readycheck.enabled then
    return
  end

  return L.F.CreateIcon(self.Health, "OVERLAY", nil, self.cfg.readycheck.size, self.cfg.readycheck.point)
end
L.F.CreateReadyCheckIndicator = CreateReadyCheckIndicator
