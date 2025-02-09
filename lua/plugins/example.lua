
return {
  {
    "lazyvim/lazyvim",
    config = function()
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        callback = function()
          -- Avoid affecting the Alpha dashboard
          if vim.bo.filetype == "alpha" then
            return
          end

          -- Set background to black
          vim.api.nvim_set_hl(0, "Normal", { fg = "#000000", bg = "#000000" })
          vim.api.nvim_set_hl(0, "NormalNC", { fg = "#000000", bg = "#000000" })

          -- Hide text by setting fg and bg to the same color
        
local highlight_groups = {
            "Normal", "NormalNC", "Comment", "Keyword", "Statement", "Type",
            "Function", "String", "Constant", "Operator", "PreProc", "Special",
            "Title", "Identifier", "Number", "Boolean", "Float", "Conditional",
            "Repeat", "CursorLine", "CursorColumn", "Cursor", "Search",
            "MatchParen", "LineNr", "NonText", "SpecialKey", "Folded",
            "SignColumn", "VertSplit", "ColorColumn", "Whitespace",
            "TreesitterContext", "TreesitterContextLineNumber",
            "@punctuation", "@punctuation.bracket", "@punctuation.special",
            "@punctuation.delimiter"
          }


          for _, group in ipairs(highlight_groups) do
            vim.api.nvim_set_hl(0, group, { fg = "#000000", bg = "#000000" }) -- Fully hide text
          end

          -- Ensure CursorLine doesn't reveal text
          vim.api.nvim_set_hl(0, "CursorLine", { bg = "#000000" })
          vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#000000" })
          vim.api.nvim_set_hl(0, "Cursor", { fg = "#000000", bg = "#000000" }) -- Hide cursor text

          -- Override Treesitter highlighting
          vim.cmd("hi! link @none Normal")
          vim.cmd("hi! link @comment Normal")
          vim.cmd("hi! link @keyword Normal")
          vim.cmd("hi! link @variable Normal")
          vim.cmd("hi! link @function Normal")
          vim.cmd("hi! link @type Normal")
          vim.cmd("hi! link @string Normal")
          vim.cmd("hi! link @number Normal")
        end,
      })

      -- Ensure Alpha dashboard text remains visible
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "alpha",
        callback = function()
          vim.cmd("colorscheme default") -- Restore colors for the dashboard
        end,
      })

      vim.cmd.colorscheme("default") -- Set an initial colorscheme
    end,
  },
}

