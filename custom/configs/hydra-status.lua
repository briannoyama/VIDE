local overriden_modules = function(modules)
  local hydra_statusline = require("hydra.statusline")
  if hydra_statusline.is_active()  then
    modules[1] = "%#St_ReplaceMode# " .. hydra_statusline.get_name() .. " " .. modules[1]
  end
end

return overriden_modules

