local A, L = ...

-- CreateAuraTimer: creates the timer text for an aura.
local function CreateAuraTimer(self, elapsed)
  self.elapsed = (self.elapsed or 0) + elapsed

  if self.elapsed >= 0.1 then
    local timeLeft = self.timeLeft - GetTime()
    if timeLeft > 0 then
      self.Cooldown:SetText(L.F.TimerFormat(timeLeft))
    else
      self:SetScript("OnUpdate", nil)
      self.Cooldown:SetText("")
    end
    self.elapsed = 0
  end
end

-- CalcFrameSize: calculate the width and height for a frame based on
-- conditions.
local function CalcFrameSize(numButtons, numCols, buttonWidth, buttonHeight, buttonMargin, framePadding)
  local numRows = ceil(numButtons / numCols)
  local frameWidth = numCols * buttonWidth + (numCols - 1) * buttonMargin + 2 * framePadding
  local frameHeight = numRows * buttonHeight + (numRows - 1) * buttonMargin + 2 * framePadding

  return frameWidth, frameHeight
end

-- PostCreateButton: callback function called after aura button is created.
local function PostCreateButton(self, button)
  button:SetFrameStrata("LOW")

  local border = button:CreateTexture(nil, "BACKGROUND")
  border:SetColorTexture(0, 0, 0)
  border:SetPoint("TOPLEFT", -1, 1)
  border:SetPoint("BOTTOMRIGHT", 1, -1)
  button.border = border

  button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

  button.Cooldown = L.F.CreateText(button, STANDARD_TEXT_FONT, 14, "OUTLINE", "CENTER", true)
  button.Cooldown:ClearAllPoints()
  button.Cooldown:SetPoint("TOP", button, 0, 4)

  button.Count:SetFont(STANDARD_TEXT_FONT, self.size / 1.65, "OUTLINE")
  button.Count:SetShadowColor(0, 0, 0, 0.6)
  button.Count:SetShadowOffset(1, -1)
  button.Count:ClearAllPoints()
  button.Count:SetPoint("BOTTOMRIGHT", self.size / 10, -self.size / 10)
end

-- PostUpdateButton: callback function called after the aura button is updated.
local function PostUpdateButton(self, button, unit, data)
  if data.duration and data.duration > 0 then
    button.timeLeft = data.expirationTime
    button:SetScript("OnUpdate", CreateAuraTimer)
    button.Cooldown:Show()
  else
    button:SetScript("OnUpdate", nil)
    button.Cooldown:Hide()
  end
end

-- CreateBuffs: create buffs frame.
local function CreateBuffs(self)
  if not self.cfg.buffs or not self.cfg.buffs.enabled then
    return
  end

  local cfg = self.cfg.buffs
  local frame = CreateFrame("Frame", nil, self)
  L.F.SetPoint(frame, self, cfg.point)
  frame.num = cfg.num
  frame.size = cfg.size
  frame.spacing = cfg.spacing
  frame.initialAnchor = cfg.initialAnchor
  frame["growth-x"] = cfg.growthX
  frame["growth-y"] = cfg.growthY
  frame.disableCooldown = cfg.disableCooldown
  frame.filter = cfg.filter
  frame.FilterAura = cfg.FilterAura
  frame.PostCreateButton = PostCreateButton
  frame.PostUpdateButton = PostUpdateButton
  frame:SetSize(CalcFrameSize(cfg.num, cfg.cols, cfg.size, cfg.size, cfg.spacing, 0))

  return frame
end
L.F.CreateBuffs = CreateBuffs

-- CreateDebuffs: create debuffs frame.
local function CreateDebuffs(self)
  if not self.cfg.debuffs or not self.cfg.debuffs.enabled then
    return
  end

  local cfg = self.cfg.debuffs
  local frame = CreateFrame("Frame", nil, self)
  L.F.SetPoint(frame, self, cfg.point)
  frame.num = cfg.num
  frame.size = cfg.size
  frame.spacing = cfg.spacing
  frame.initialAnchor = cfg.initialAnchor
  frame["growth-x"] = cfg.growthX
  frame["growth-y"] = cfg.growthY
  frame.disableCooldown = cfg.disableCooldown
  frame.filter = cfg.filter
  frame.FilterAura = cfg.FilterAura
  frame.onlyShowPlayer = cfg.onlyShowPlayer
  frame.PostCreateButton = PostCreateButton
  frame.PostUpdateButton = PostUpdateButton
  frame:SetSize(CalcFrameSize(cfg.num, cfg.cols, cfg.size, cfg.size, cfg.spacing, 0))

  return frame
end
L.F.CreateDebuffs = CreateDebuffs
