local A, L = ...

local unpack = unpack

local function NumberFormat(v)
  if v > 1E10 then
    return (string.format("%.1f", v / 1E9)) .. "B"
  elseif v > 1E9 then
    return (string.format("%.1f", (v / 1E9) * 10) / 10) .. "B"
  elseif v > 1E7 then
    return (string.format("%.1f", v / 1E6)) .. "M"
  elseif v > 1E6 then
    return (string.format("%.1f", (v / 1E6) * 10) / 10) .. "M"
  elseif v > 1E4 then
    return (string.format("%.1f", (v / 1E3))) .. "K"
  elseif v > 1E3 then
    return (string.format("%.0f", (v / 1E3) * 10) / 10) .. "K"
  else
    return v
  end
end
L.F.NumberFormat = NumberFormat

local function SetPoint(self, relativeTo, point)
  -- adjust the setpoint function to make it possible to reference a relativeTo
  -- object that is set on runtime and it not available on config init
  local a, b, c, d, e = unpack(point)

  if not b then
    self:SetPoint(a)
  elseif b and type(b) == "string" and not _G[b] then
    self:SetPoint(a, relativeTo, b, c, d)
  else
    self:SetPoint(a, b, c, d, e)
  end
end
L.F.SetPoint = SetPoint

local function SetPoints(self, relativeTo, points)
  for i, point in next, points do
    SetPoint(self, relativeTo, point)
  end
end
L.F.SetPoints = SetPoints

local function CreateBackdrop(self, relativeTo)
  local backdrop = L.C.backdrop
  local bd = CreateFrame("Frame", nil, self, BackdropTemplateMixin and "BackdropTemplate")

  bd:SetFrameLevel(self:GetFrameLevel() - 1 or 0)
  bd:SetPoint("TOPLEFT", relativeTo or self, "TOPLEFT", -backdrop.inset, backdrop.inset)
  bd:SetPoint("BOTTOMRIGHT", relativeTo or self, "BOTTOMRIGHT", backdrop.inset, -backdrop.inset)
  bd:SetBackdrop(backdrop)
  bd:SetBackdropColor(unpack(backdrop.bgColor))
  bd:SetBackdropBorderColor(unpack(backdrop.edgeColor))

  return bd
end
L.F.CreateBackdrop = CreateBackdrop

local function CreateIcon(self, layer, sublevel, size, point)
  local icon = self:CreateTexture(nil, layer, nil, sublevel)
  icon:SetSize(unpack(size))
  SetPoint(icon, self, point)

  return icon
end
L.F.CreateIcon = CreateIcon

local function CreateText(self, font, size, outline, align, noshadow)
  local text = self:CreateFontString(nil, "ARTWORK")
  text:SetFont(font or STANDARD_TEXT_FONT, size or 14, outline or "OUTLINE")
  text:SetJustifyH(align or "LEFT")

  if not noshadow then
    text:SetShadowColor(0, 0, 0, 0.6)
    text:SetShadowOffset(1, -1)
  end

  -- fix some wierd bug
  text:SetText("Bugfix")
  text:SetMaxLines(1)
  text:SetHeight(text:GetStringHeight())

  return text
end
L.F.CreateText = CreateText
