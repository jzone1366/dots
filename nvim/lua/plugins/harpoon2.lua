local map = require("utils").map

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup()

        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        map("n", "<leader>th", function() toggle_telescope(harpoon:list()) end,
            { desc = "Open harpoon window" })
        map("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add file to harpoon" })

        map("n", "<C-1>", function() harpoon:list():select(1) end, { desc = "Select harpoon file 1" })
        map("n", "<C-2>", function() harpoon:list():select(2) end, { desc = "Select harpoon file 2" })
        map("n", "<C-3>", function() harpoon:list():select(3) end, { desc = "Select harpoon file 3" })
        map("n", "<C-4>", function() harpoon:list():select(4) end, { desc = "Select harpoon file 4" })

        -- Toggle previous & next buffers stored within Harpoon list
        map("n", "<C-S-P>", function() harpoon:list():prev() end)
        map("n", "<C-S-N>", function() harpoon:list():next() end)
    end
}
