return {
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'gbrlsnchs/telescope-lsp-handlers.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'nvim-telescope/telescope-github.nvim',
            'cljoly/telescope-repo.nvim',
        },
        config = function()
            local telescope = require("telescope")
            local actions = require "telescope.actions"
            local map = require("utils").map
            local builtin = require('telescope.builtin')

            telescope.setup {
                defaults = {
                    layout_strategy = 'flex',
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<esc>"] = require('telescope.actions').close,
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    lsp_handlers = {
                        code_action = {
                            telescope = require('telescope.themes').get_dropdown({}),
                        },
                    },
                    advanced_git_search = {
                        -- Fugitive or diffview
                        diff_plugin = "diffview",
                        -- Customize git in previewer
                        -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
                        git_flags = {},
                        -- Customize git diff in previewer
                        -- e.g. flags such as { "--raw" }
                        git_diff_flags = {},
                        -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
                        show_builtin_git_pickers = false,
                    },
                },
            }
            telescope.load_extension("fzf")
            telescope.load_extension('lsp_handlers')
            telescope.load_extension('gh')
            telescope.load_extension('repo')
            telescope.load_extension("advanced_git_search")

            -- @TODO: Figure out why this doesn't work
            --telescope.load_extension('project')

            local function git_branches()
                builtin.git_branches({ show_remote_tracking_branches = false })
            end

            map("n", "<leader>tf", builtin.find_files, { silent = true, desc = "Telescope find files" })
            map("n", "<leader>tt", builtin.help_tags, { silent = true, desc = "Telescope help tags" })
            map("n", "<leader>tg", builtin.live_grep, { silent = true, desc = "Telescope live grep" })
            map("n", "<leader>tk", builtin.keymaps, { silent = true, desc = "Telescope keymaps" })
            map("n", "<leader>td", builtin.diagnostics, { silent = true, desc = "Telescope diagnostics" })
            map("n", "<leader>t;", telescope.extensions.repo.list, { silent = true, desc = "Telescope repo list" })
            map("n", "<leader>tb", builtin.buffers, { silent = true, desc = "Telescope buffers" })
            -- shows all diff for current buffer
            map("n", "<leader>gd", builtin.git_bcommits, { silent = true, desc = "Telescope git bcommits" })
            map("n", "<leader>gl", builtin.git_commits, { silent = true, desc = "Telescope git commits" })
            map("n", "<leader>gb", git_branches, { silent = true, desc = "Telescope git branches" })
            map("n", "<leader>gs", builtin.git_status, { silent = true, desc = "Telescope git status" })
            -- list of all previous commits. Grep commit content
            map("n", "<leader>ghh", telescope.extensions.advanced_git_search.search_log_content,
                { silent = true, desc = "Telescope advanced git search log content" })
            -- list of git commits that changed the current file. Grep commit content
            map("n", "<leader>ghf", telescope.extensions.advanced_git_search.search_log_content_file,
                { silent = true, desc = "Telescope advanced git search log content file" })
            -- list of git commits that changed the current file. Grep commit message
            map("n", "<leader>ghc", telescope.extensions.advanced_git_search.diff_commit_file,
                { silent = true, desc = "Telescope advanced git search diff commit file" })
        end,
    },
    { 'nvim-lua/plenary.nvim',                 dependencies = { "nvim-telescope/telescope.nvim" } },
    { "gbrlsnchs/telescope-lsp-handlers.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
    { "nvim-telescope/telescope-github.nvim",  dependencies = { "nvim-telescope/telescope.nvim" } },
    { "cljoly/telescope-repo.nvim",            dependencies = { "nvim-telescope/telescope.nvim" } },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        dependencies = { "nvim-telescope/telescope.nvim" },
    },
    {
        "aaronhallaert/advanced-git-search.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "tpope/vim-fugitive",
        },
    },
}
