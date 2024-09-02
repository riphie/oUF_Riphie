local _, L = ...

if not L.C.focus or not L.C.focus.enabled then
  return
end

local function CreateFocusStyle(self)
  -- config
  self.cfg = L.C.focus

  -- settings
  self.settings = {}
  self.settings.template = "focus"
  self.settings.setupFrame = true
  self.settings.setupHeader = true

  -- style
  L.F.CreateStyle(self)
end
L.F.CreateFocusStyle = CreateFocusStyle
