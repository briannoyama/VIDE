return function(modules)
  local hydra_statusline = require "hydra.statusline"
  if hydra_statusline.is_active() then
    modules[1] = "%#St_ReplaceMode# "
      .. hydra_statusline.get_name()
      .. " %#St_ReplaceModeSep# %#ST_EmptySpace#"
  end
end
