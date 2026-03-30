return {
    "render_markdown.nvim",
    event = { "BufReadPost *.md", "BufNewFile *.md" },
    config = function()
        require('render_markdown').setup({
            highlight_code_blocks = true,
            languages = { 'cpp', 'python' },
            auto_enable = true,
            commands = {
                toggle = function() require('render_markdown').toggle() end,
                enable = function() require('render_markdown').enable() end,
                disable = function() require('render_markdown').disable() end,
            },
        })
    end,
}