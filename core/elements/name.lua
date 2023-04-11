local A, L = ...

local function CreateNameText(self)
  if not self.cfg.healthbar or not self.cfg.healthbar.name or not self.cfg.healthbar.name.enabled then
    return
  end

  local cfg = self.cfg.healthbar.name
  local text = L.F.CreateText(self.Health, cfg.font, cfg.size, cfg.outline, cfg.align, cfg.noshadow)

  if cfg.points then
    L.F.SetPoints(text, self.Health, cfg.points)
  else
    L.F.SetPoint(text, self.Health, cfg.point)
  end

  self:Tag(text, cfg.tag)

  return text
end
L.F.CreateNameText = CreateNameText
