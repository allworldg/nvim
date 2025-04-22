local M = {}
local log_data = {}

M.set_logData = function(data)
  table.insert(log_data, data)
end
M.print = function()
  for k, v in pairs(log_data) do
    print(v)
  end
end
M.write = function()
  local out = io.open("test.log", "w")
  for k, v in pairs(log_data) do
    out:write(k..": "..v)
    out:write("\n")
  end
  out:close()
end
return M
