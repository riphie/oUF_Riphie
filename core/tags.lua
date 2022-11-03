local A, L = ...
local oUF = L.oUF or oUF

local floor = floor

-- tag method: oUF_Riphie:health
oUF.Tags.Methods["oUF_Riphie:health"] = function(unit)
  if not UnitIsConnected(unit) then
    return "|cff999999Offline|r"
  end

  if UnitIsDead(unit) or UnitIsGhost(unit) then
    return "|cff999999Dead|r"
  end

  local hpmin, hpmax = UnitHealth(unit), UnitHealthMax(unit)
  local hpper = 0

  if hpmax > 0 then
    hpper = floor(hpmin / hpmax * 100)
  end

  return L.F.NumberFormat(hpmin)
end

-- tag event: oUF_Riphie:health
oUF.Tags.Events["oUF_Riphie:health"] = "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION"

-- load tags from the config
if not L.C.tagMethods and type(L.C.tagMethods) ~= "table" then
  return
end
if not L.C.tagEvents and type(L.C.tagEvents) ~= "table" then
  return
end

for key, value in next, L.C.tagMethods do
  if L.C.tagMethods[key] and L.C.tagEvents[key] then
    oUF.Tags.Methods[key] = L.C.tagMethods[key]
    oUF.Tags.Events[key] = L.C.tagEvents[key]
  end
end

-- add player regen to the unitless event tags
oUF.Tags.SharedEvents["PLAYER_REGEN_DISABLED"] = true
oUF.Tags.SharedEvents["PLAYER_REGEN_ENABLED"] = true
