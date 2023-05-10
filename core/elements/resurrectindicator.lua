local A, L = ...

-- CreateResurrectIndicator: create a resurrect indicator icon.
local function CreateResurrectIndicator(self)
  if not self.cfg.resurrect or not self.cfg.resurrect.enabled then
    return
  end

  return L.F.CreateIcon(self.Health, "OVERLAY", nil, self.cfg.resurrect.size, self.cfg.resurrect.point)
end
L.F.CreateResurrectIndicator = CreateResurrectIndicator
