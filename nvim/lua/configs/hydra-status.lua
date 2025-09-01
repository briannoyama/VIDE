return function()
  local hydra_statusline = require "hydra.statusline"
  if hydra_statusline.is_active() then
    return "%#St_ReplaceMode# " .. hydra_statusline.get_name() .. " %#St_ReplaceModeSep# %#ST_EmptySpace#"
  end
  return ""
end
