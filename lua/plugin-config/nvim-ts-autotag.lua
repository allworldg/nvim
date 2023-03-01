local status,tsautotag = pcall(require,"nvim-ts-autotag")

if not status then
  vim.notify("not found tsautotag")
end


tsautotag.setup()
