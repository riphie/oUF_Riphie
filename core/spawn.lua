local A, L = ...
local oUF = L.oUF or oUF

local unpack = unpack

if L.F.CreatePlayerStyle then
  oUF:RegisterStyle(A .. "Player", L.F.CreatePlayerStyle)
  oUF:SetActiveStyle(A .. "Player")
  oUF:Spawn("player", A .. "Player")
end

if L.F.CreateTargetStyle then
  oUF:RegisterStyle(A .. "Target", L.F.CreateTargetStyle)
  oUF:SetActiveStyle(A .. "Target")
  oUF:Spawn("target", A .. "Target")
end

if L.F.CreateTargetTargetStyle then
  oUF:RegisterStyle(A .. "TargetTarget", L.F.CreateTargetTargetStyle)
  oUF:SetActiveStyle(A .. "TargetTarget")
  oUF:Spawn("targettarget", A .. "TargetTarget")
end

if L.F.CreatePetStyle then
  oUF:RegisterStyle(A .. "Pet", L.F.CreatePetStyle)
  oUF:SetActiveStyle(A .. "Pet")
  oUF:Spawn("pet", A .. "Pet")
end

if L.F.CreateFocusStyle then
  oUF:RegisterStyle(A .. "Focus", L.F.CreateFocusStyle)
  oUF:SetActiveStyle(A .. "Focus")
  oUF:Spawn("focus", A .. "Focus")
end

if L.F.CreatePartyStyle then
  oUF:RegisterStyle(A .. "Party", L.F.CreatePartyStyle)
  oUF:SetActiveStyle(A .. "Party")
  oUF
    :SpawnHeader(
      A .. "PartyHeader",
      L.C.party.setup.template,
      L.C.party.setup.visibility,
      "showPlayer",
      L.C.party.setup.showPlayer,
      "showSolo",
      L.C.party.setup.showSolo,
      "showParty",
      L.C.party.setup.showParty,
      "showRaid",
      L.C.party.setup.showRaid,
      "point",
      L.C.party.setup.point,
      "xOffset",
      L.C.party.setup.xOffset,
      "yOffset",
      L.C.party.setup.yOffset,
      "oUF-initialConfigFunction",
      ([[
      self:SetWidth(%d)
      self:SetHeight(%d)
      self:GetParent():SetScale(%f)
    ]]):format(L.C.party.size[1], L.C.party.size[2], L.C.party.scale)
    )
    :SetPoint(unpack(L.C.party.point))
end

if L.F.CreateBossStyle then
  oUF:RegisterStyle(A .. "Boss", L.F.CreateBossStyle)
  oUF:SetActiveStyle(A .. "Boss")

  local boss = {}

  for i = 1, MAX_BOSS_FRAMES do
    boss[i] = oUF:Spawn("boss" .. i, A .. "Boss" .. i)

    if i == 1 then
      boss[i]:SetPoint(unpack(L.C.boss.point))
    else
      boss[i]:SetPoint(
        L.C.boss.setup.point,
        boss[i - 1],
        L.C.boss.setup.relativePoint,
        L.C.boss.setup.xOffset,
        L.C.boss.setup.yOffset
      )
    end
  end
end

if L.F.CreateNamePlateStyle then
  oUF:RegisterStyle(A .. "Nameplate", L.F.CreateNamePlateStyle)
  oUF:SetActiveStyle(A .. "Nameplate")
  oUF:SpawnNamePlates(A, L.C.NamePlateCallback, L.C.NamePlateCVars)
end

if L.F.CreateRaidStyle then
  oUF:RegisterStyle(A .. "Raid", L.F.CreateRaidStyle)
  oUF:SetActiveStyle(A .. "Raid")

  for i = 1, NUM_RAID_GROUPS do
    oUF
      :SpawnHeader(
        A .. "RaidHeader" .. i,
        L.C.raid.setup.template,
        L.C.raid.setup.visibility,
        "showPlayer",
        L.C.raid.setup.showPlayer,
        "showSolo",
        L.C.raid.setup.showSolo,
        "showParty",
        L.C.raid.setup.showParty,
        "showRaid",
        L.C.raid.setup.showRaid,
        "point",
        L.C.raid.setup.point,
        "xOffset",
        L.C.raid.setup.xOffset,
        "yOffset",
        L.C.raid.setup.yOffset,
        "groupFilter",
        tostring(i),
        "unitsPerColumn",
        5,
        "oUF-initialConfigFunction",
        ([[
          self:SetWidth(%d)
          self:SetHeight(%d)
          self:GetParent():SetScale(%f)
        ]]):format(L.C.raid.size[1], L.C.raid.size[2], L.C.raid.scale)
      )
      :SetPoint(unpack(L.C.raid.points[i])) --config needs to provide 8 point tables, one for each raid group
  end
end
