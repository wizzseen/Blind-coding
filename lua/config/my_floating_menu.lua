
local function create_file(extension)
    local filename = "code." .. extension
    vim.cmd("e " .. filename) -- Open the file in Neovim
    vim.api.nvim_win_close(0, true) -- Close floating window
end

local function create_floating_menu()
    local buf = vim.api.nvim_create_buf(false, true) -- Create a buffer
    local width = 30
    local height = 10
    local opts = {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = "minimal",
        border = "rounded",
    }

    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Options List
    local options = { "Python", "Java", "C", "C++" }
    local extensions = { python = "py", java = "java", c = "c", cpp = "cpp" }

    -- Insert text into buffer
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
        " Select a language:",
        " 1. Python",
        " 2. Java",
        " 3. C",
        " 4. C++",
        "",
        " Press the number key to select",
    })

    -- Function to handle selection
    local function select_option(key)
        local ext_map = { ["1"] = "py", ["2"] = "java", ["3"] = "c", ["4"] = "cpp" }
        local ext = ext_map[key]
        if ext then
            create_file(ext)
        end
    end

    -- Key mappings for selecting options
    for key, ext in pairs({ ["1"] = "py", ["2"] = "java", ["3"] = "c", ["4"] = "cpp" }) do
        vim.api.nvim_buf_set_keymap(buf, "n", key, "", {
            noremap = true,
            silent = true,
            callback = function() select_option(key) end,
        })
    end
end

-- Keybinding to show the floating menu
vim.api.nvim_set_keymap("n", "<leader>r", "", { noremap = true, silent = true, callback = create_floating_menu })

