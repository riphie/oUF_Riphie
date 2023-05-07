local A, L = ...

-- Up-value used global functions
local unpack = unpack

-- NumberFormat: abbreviate a number into billions, millions, and thousands.
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

-- TimerFormat: format a timer text.
local function TimerFormat(v)
  local day, hour, minute = 86400, 3600, 60

  if v >= day then
    return format("%dd", floor(v / day + 0.5)), v % day
  elseif v >= hour then
    return format("%dh", floor(v / hour + 0.5)), v % hour
  elseif v >= minute then
    if v <= minute * 5 then
      return format("%d:%02d", floor(v / 60), v % minute), v - floor(v)
    else
      return format("%dm", floor(v / minute + 0.5)), v % minute
    end
  else
    return format("%d", v + 0.5), v - floor(v)
  end
end
L.F.TimerFormat = TimerFormat

-- SetWidth: set the width for the frame.
local function SetWidth(self, width)
  PixelUtil.SetWidth(self, width, 1, 1)
end
L.F.SetWidth = SetWidth

-- SetHeight: set the height for the frame.
local function SetHeight(self, height)
  PixelUtil.SetHeight(self, height, 1, 1)
end
L.F.SetHeight = SetHeight

-- SetSize: set the size for the frame.
local function SetSize(self, width, height)
  PixelUtil.SetSize(self, width, height, 1, 1)
end
L.F.SetSize = SetSize

-- SetPoint: set the point for the frame, to the relative frame.
local function SetPoint(self, relativeTo, point)
  local a, b, c, d, e = unpack(point)

  if not b then
    self:SetPoint(a)
  elseif b and type(b) == "string" and not _G[b] then
    PixelUtil.SetPoint(self, a, relativeTo, b, c or 0, d or 0, 0, 0)
  else
    PixelUtil.SetPoint(self, a, b or nil, c or nil, d or 0, e or 0, 0, 0)
  end
end
L.F.SetPoint = SetPoint

-- SetPoints: set multiple points for the frame, to the relative frame.
local function SetPoints(self, relativeTo, points)
  for i, point in next, points do
    L.F.SetPoint(self, relativeTo, point)
  end
end
L.F.SetPoints = SetPoints

-- CreateBackdrop: create a backdrop frame to go behind the relative frame.
local function CreateBackdrop(self, relativeTo)
  local backdrop = L.C.backdrop
  local bd = CreateFrame("Frame", nil, self, BackdropTemplateMixin and "BackdropTemplate")

  bd:SetFrameLevel(self:GetFrameLevel() - 1 or 0)
  L.F.SetPoint(bd, relativeTo or self, { "TOPLEFT", "TOPLEFT", -backdrop.inset, backdrop.inset })
  L.F.SetPoint(bd, relativeTo or self, { "BOTTOMRIGHT", "BOTTOMRIGHT", backdrop.inset, -backdrop.inset })
  bd:SetBackdrop(backdrop)
  bd:SetBackdropColor(unpack(backdrop.bgColor))
  bd:SetBackdropBorderColor(unpack(backdrop.edgeColor))

  return bd
end
L.F.CreateBackdrop = CreateBackdrop

-- CreateIcon: create an icon texture.
local function CreateIcon(self, layer, sublevel, size, point)
  local icon = self:CreateTexture(nil, layer, nil, sublevel)
  L.F.SetSize(icon, unpack(size))
  L.F.SetPoint(icon, self, point)

  return icon
end
L.F.CreateIcon = CreateIcon

-- CreateText: create a font string.
local function CreateText(self, font, size, outline, align, noshadow)
  local text = self:CreateFontString(nil, "ARTWORK")
  text:SetFont(font or STANDARD_TEXT_FONT, size or 14, outline or "OUTLINE")
  text:SetJustifyH(align or "LEFT")

  if not noshadow then
    text:SetShadowColor(0, 0, 0, 0.6)
    text:SetShadowOffset(1, -1)
  end

  text:SetMaxLines(1)
  L.F.SetHeight(text, text:GetStringHeight())

  return text
end
L.F.CreateText = CreateText
