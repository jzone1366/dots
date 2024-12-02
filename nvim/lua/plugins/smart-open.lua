return {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    lazy = false,
    config = function()
        local map = require("utils").map
        require("telescope").load_extension("smart_open")
        map("n", "<leader>ts", function() require("telescope").extensions.smart_open.smart_open() end,
            { silent = true, desc = "Telescope find files" })
    end,
    dependencies = {
        "kkharji/sqlite.lua",
        -- Only required if using match_algorithm fzf
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
}
