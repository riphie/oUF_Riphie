local _, L = ...

-- CreateAuraTimer: creates the timer text for an aura.
local function CreateAuraTimer(self, elapsed)
  self.elapsed = (self.elapsed or 0) + elapsed

  if self.elapsed >= 0.1 then
    local timeLeft = self.timeLeft - GetTime()
    if timeLeft > 0 then
      self.Cooldown:SetText(L.F.TimerFormat(timeLeft))
    else
      self:SetScript("OnUpdate", nil)
      self.Cooldown:SetText ""
    end
    self.elapsed = 0
  end
end

-- CalcFrameSize: calculate the width and height for a frame based on
-- conditions.
local function CalcFrameSize(numButtons, numCols, buttonWidth, buttonHeight, buttonMargin, framePadding)
  local numRows = math.ceil(numButtons / numCols)
  local frameWidth = numCols * buttonWidth + (numCols - 1) * buttonMargin + 2 * framePadding
  local frameHeight = numRows * buttonHeight + (numRows - 1) * buttonMargin + 2 * framePadding

  return frameWidth, frameHeight
end

-- PostCreateButton: callback function called after aura button is created.
local function PostCreateButton(self, button)
  button:SetFrameStrata "LOW"

  local border = button:CreateTexture(nil, "BACKGROUND")
  border:SetColorTexture(0, 0, 0)
  L.F.SetPoint(border, button, { "TOPLEFT", "TOPLEFT", -1, 1 })
  L.F.SetPoint(border, button, { "BOTTOMRIGHT", "BOTTOMRIGHT", 1, -1 })
  button.border = border

  button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

  local duration = self.cfg.duration

  button.Cooldown =
    L.F.CreateText(button, duration.font, duration.size, duration.outline, duration.align, duration.noshadow)
  button.Cooldown:ClearAllPoints()
  L.F.SetPoint(button.Cooldown, button, duration.point)

  local count = self.cfg.count

  button.Count = L.F.CreateText(button, count.font, count.size, count.outline, count.align, count.noshadow)
  button.Count:ClearAllPoints()
  L.F.SetPoint(button.Count, button, count.point)
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
  frame.cfg = cfg
  L.F.SetPoint(frame, self, cfg.point)
  frame.num = cfg.num
  frame.size = cfg.size
  frame.spacing = cfg.spacing
  frame.initialAnchor = cfg.initialAnchor
  frame["growth-x"] = cfg.growthX
  frame["growth-y"] = cfg.growthY
  frame["spacing-x"] = cfg.spacingX
  frame["spacing-y"] = cfg.spacingY
  frame.disableMouse = cfg.disableMouse
  frame.disableCooldown = cfg.disableCooldown
  frame.filter = cfg.filter
  frame.FilterAura = cfg.FilterAura
  frame.PostCreateButton = PostCreateButton
  frame.PostUpdateButton = PostUpdateButton
  L.F.SetSize(frame, CalcFrameSize(cfg.num, cfg.cols, cfg.size, cfg.size, cfg.spacing, 0))

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
  frame.cfg = cfg
  L.F.SetPoint(frame, self, cfg.point)
  frame.num = cfg.num
  frame.size = cfg.size
  frame.spacing = cfg.spacing
  frame.initialAnchor = cfg.initialAnchor
  frame["growth-x"] = cfg.growthX
  frame["growth-y"] = cfg.growthY
  frame["spacing-x"] = cfg.spacingX
  frame["spacing-y"] = cfg.spacingY
  frame.disableMouse = cfg.disableMouse
  frame.disableCooldown = cfg.disableCooldown
  frame.filter = cfg.filter
  frame.FilterAura = cfg.FilterAura
  frame.onlyShowPlayer = cfg.onlyShowPlayer
  frame.PostCreateButton = PostCreateButton
  frame.PostUpdateButton = PostUpdateButton
  L.F.SetSize(frame, CalcFrameSize(cfg.num, cfg.cols, cfg.size, cfg.size, cfg.spacing, 0))

  return frame
end
L.F.CreateDebuffs = CreateDebuffs
