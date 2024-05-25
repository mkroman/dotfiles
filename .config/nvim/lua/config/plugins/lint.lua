local lint = require('lint')

lint.linters_by_ft = {
  sql = { 'sqlfluff', }
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    lint.try_lint()
  end,
})
