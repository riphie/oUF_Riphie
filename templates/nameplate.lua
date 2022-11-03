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
