return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  -- stylua: ignore
  keys = {
    { "n", mode = { "n", "x", "o" }, function() require("flash").jump({continue = true}) end, desc = "Flash" },
    { "*", mode = { "n", "x", "o" }, function() require("flash").jump({pattern = vim.fn.expand("<cword>"), continue = true}) end, desc = "Flash word search" },
    { "N", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<F2>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
