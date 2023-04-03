local state,_ = pcall(require,"lazy")
if not state then
  vim.cmd[[ colorscheme desert ]]
end
