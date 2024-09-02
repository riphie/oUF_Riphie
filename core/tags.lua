local _, L = ...
local oUF = L.oUF or oUF

-- oUF_Riphie:health: show s offline/dead status, and the current health points.
oUF.Tags.Methods["oUF_Riphie:health"] = function(unit)
  if not UnitIsConnected(unit) then
    return "|cff999999Offline|r"
  end

  if UnitIsDead(unit) or UnitIsGhost(unit) then
    return "|cff999999Dead|r"
  end

  local hpmin = UnitHealth(unit)

  return L.F.NumberFormat(hpmin)
end
oUF.Tags.Events["oUF_Riphie:health"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION"

-- Load any tag methods and events from the config.
if not L.C.tagMethods and type(L.C.tagMethods) ~= "table" then
  return
end
if not L.C.tagEvents and type(L.C.tagEvents) ~= "table" then
  return
end

for key, _ in next, L.C.tagMethods do
  if L.C.tagMethods[key] and L.C.tagEvents[key] then
    oUF.Tags.Methods[key] = L.C.tagMethods[key]
    oUF.Tags.Events[key] = L.C.tagEvents[key]
  end
end

-- Add player regen to the unitless event tags
oUF.Tags.SharedEvents["PLAYER_REGEN_DISABLED"] = true
oUF.Tags.SharedEvents["PLAYER_REGEN_ENABLED"] = true
