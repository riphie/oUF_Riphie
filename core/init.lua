local A, L = ...

-- Use embedded or global oUF
local oUF = L.oUF or oUF

-- Update mana color to a better color
oUF.colors.power["MANA"] = { 0, 0.55, 1 }

-- Config table
L.C = oUF_RiphieConfig

-- Functions table
L.F = {}
