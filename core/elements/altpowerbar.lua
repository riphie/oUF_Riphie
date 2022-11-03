local A, L = ...

local unpack = unpack

local function AltPowerBarOverride(self, event, unit, powerType)
  if self.unit ~= unit or powerType ~= "ALTERNATE" then
    return
  end

  local ppmax = UnitPowerMax(unit, ALTERNATE_POWER_INDEX, true) or 0
  local ppcur = UnitPower(unit, ALTERNATE_POWER_INDEX, true)
  local _, r, g, b = UnitAlternatePowerTextureInfo(unit, 2)
  local _, ppmin = UnitAlternatePowerInfo(unit)

  local el = self.AltPowerBar
  el:SetMinMaxValues(ppmin or 0, ppmax)
  el:SetValue(ppcur)

  if b then
    el:SetStatusBarColor(r, g, b)

    if el.bg then
      local mu = el.bg.multiplier or 0.3
      el.bg:SetVertexColor(r * mu, g * mu, b * mu)
    end
  else
    el:SetStatusBarColor(1, 0, 1)

    if el.bg then
      local mu = el.bg.multiplier or 0.3
      el.bg:SetVertexColor(1 * mu, 0 * mu, 1 * mu)
    end
  end
end

local function CreateAltPowerBar(self)
  if not self.cfg.altpowerbar or not self.cfg.altpowerbar.enabled then
    return
  end

  local altpowerbar = CreateFrame("StatusBar", nil, self)
  altpowerbar:SetStatusBarTexture(L.C.textures.statusbar)
  altpowerbar:SetSize(unpack(self.cfg.altpowerbar.size))
  SetPoint(altpowerbar, self, self.cfg.altpowerbar.point)

  local bg = altpowerbar:CreateTexture(nil, "BACKGROUND")
  bg:SetTexture(L.C.textures.statusbar)
  bg:SetAllPoints()
  altpowerbar.bg = bg

  L.F.CreateBackdrop(altpowerbar)

  altpowerbar.Override = AltPowerBarOverride
  altpowerbar.bg.multiplier = L.C.colors.bgMultiplier

  return altpowerbar
end
L.F.CreateAltPowerBar = CreateAltPowerBar
