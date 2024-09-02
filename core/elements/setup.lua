local _, L = ...

-- Up-value used global functions
local unpack = unpack

-- SetupHeader: sets up the header for a frame.
local function SetupHeader(self)
  if not self.settings.setupHeader then
    return
  end

  self:RegisterForClicks "AnyDown"
  self:SetScript("OnEnter", UnitFrame_OnEnter)
  self:SetScript("OnLeave", UnitFrame_OnLeave)
end
L.F.SetupHeader = SetupHeader

-- SetupFrame: sets up the frame.
local function SetupFrame(self)
  if not self.settings.setupFrame then
    return
  end

  self:SetScale(self.cfg.scale)
  L.F.SetSize(self, unpack(self.cfg.size))
  L.F.SetPoint(self, nil, self.cfg.point)
end
L.F.SetupFrame = SetupFrame
