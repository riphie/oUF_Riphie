local A, L = ...

if not L.C.nameplate or not L.C.nameplate.enabled then
  return
end

local function CreateNamePlateStyle(self)
  -- config
  self.cfg = L.C.nameplate

  -- settings
  self.settings = {}
  self.settings.template = "nameplate"
  self.settings.setupFrame = true
  self.settings.setupHeader = false

  -- style
  L.F.CreateStyle(self)
end
L.F.CreateNamePlateStyle = CreateNamePlateStyle

local function NamePlateCallback(self, event, unit)
  if not self then
    return
  end

  local cfg = L.C.nameplate

  if cfg.friendly_only_name then
    if UnitIsFriend("player", unit) then
      -- Hide health bar
      self.Health:SetAlpha(0)

      -- Hide cast bar
      self.Castbar:SetAlpha(0)

      -- Re-parent name and set position
      self.Name:SetParent(self)
      self.Name:ClearAllPoints()
      L.F.SetPoint(self.Name, self, { "CENTER", "CENTER", 0, 0 })

      -- Re-parent raid target indicator and set position
      self.RaidTargetIndicator:SetParent(self)
      self.RaidTargetIndicator:ClearAllPoints()
      L.F.SetPoint(self.RaidTargetIndicator, self.Name, { "BOTTOM", "TOP", 0, 10 })
    else
      -- Show health bar
      self.Health:SetAlpha(1)

      -- Show cast bar
      self.Castbar:SetAlpha(1)

      -- Re-parent name and set position
      self.Name:SetParent(self.Health)
      self.Name:ClearAllPoints()

      if cfg.healthbar and cfg.healthbar.name and cfg.healthbar.name.points then
        L.F.SetPoints(self.Name, self.Health, cfg.healthbar.name.points)
      else
        L.F.SetPoint(self.Name, self.Health, cfg.healthbar.name.point)
      end

      -- Re-parent raid target indicator and set position
      self.RaidTargetIndicator:SetParent(self)
      self.RaidTargetIndicator:ClearAllPoints()

      if cfg.raidicon then
        L.F.SetPoint(self.RaidTargetIndicator, self.Health, cfg.raidicon.point)
      end
    end
  end
end
L.C.NamePlateCallback = NamePlateCallback
