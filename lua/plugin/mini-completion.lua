return{
 'nvim-mini/mini.completion', version = false,
 cond = true,
 config=function ()
   require('mini.completion').setup()
 end
}
