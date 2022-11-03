local A, L = ...

if not L.C.pet or not L.C.pet.enabled then
  return
end

local function CreatePetStyle(self)
  -- config
  self.cfg = L.C.pet

  -- settings
  self.settings = {}
  self.settings.template = "pet"
  self.settings.setupFrame = true
  self.settings.setupHeader = true

  -- style
  L.F.CreateStyle(self)
end
L.F.CreatePetStyle = CreatePetStyle
