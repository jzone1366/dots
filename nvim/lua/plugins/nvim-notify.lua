return {
    'rcarriga/nvim-notify',
    opts ={
        render = "default",
        timeout = 2000,
        background_colour = '#000000',
    },
    config = function(_, opts)
        require('notify').setup(opts)
    end,
    init = function()
        local banned_messages = {
            'No information available',
            'LSP[tsserver] Inlay Hints request failed. Requires TypeScript 4.4+.',
            'LSP[tsserver] Inlay Hints request failed. File not opened in the editor.',
        }
        vim.notify = function(msg, ...)
            for _, banned in ipairs(banned_messages) do
                if msg == banned then
                    return
                end
            end
            return require('notify')(msg, ...)
        end
    end,
}
