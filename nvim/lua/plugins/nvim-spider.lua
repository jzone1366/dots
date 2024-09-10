local map = require('utils').map

return {
    'chrisgrieser/nvim-spider',
    lazy = true,
    keys = { 'w', 'e', 'b', 'ge' },
    config = function()
        map({ 'n', 'o', 'x' }, 'W', 'w', { desc = 'Normal w' })
        map({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Spider-w' })
        map({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Spider-e' })
        map({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Spider-b' })
        map({ 'n', 'o', 'x' }, 'ge', "<cmd>lua require('spider').motion('ge')<CR>", { desc = 'Spider-ge' })
    end,
}
