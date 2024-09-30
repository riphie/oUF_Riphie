local _, L = ...

-- CreateGroupRoleIndicator: create a group role indicator icon.
local function CreateGroupRoleIndicator(self)
  if not self.cfg.grouproleindicator or not self.cfg.grouproleindicator.enabled then
    return
  end

  return L.F.CreateIcon(
    self.Health,
    "OVERLAY",
    nil,
    self.cfg.grouproleindicator.size,
    self.cfg.grouproleindicator.point
  )
end
L.F.CreateGroupRoleIndicator = CreateGroupRoleIndicator
