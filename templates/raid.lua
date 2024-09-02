local _, L = ...

if not L.C.raid or not L.C.raid.enabled then
  return
end

local function CreateRaidStyle(self)
  -- config
  self.cfg = L.C.raid

  -- settings
  self.settings = {}
  self.settings.template = "raid"
  self.settings.setupFrame = false
  self.settings.setupHeader = true

  -- style
  L.F.CreateStyle(self)
end
L.F.CreateRaidStyle = CreateRaidStyle
