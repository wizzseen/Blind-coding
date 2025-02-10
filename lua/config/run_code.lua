local function run_code()
    -- Get current file name and extension
    local filename = vim.fn.expand("%:t")
    local extension = vim.fn.expand("%:e")

    -- Define commands based on file extension

local commands = {
    py = 'python3 ' .. filename .. ' < input.txt > output.txt 2> error.txt',
    java = 'javac ' .. filename .. ' 2> error.txt && java ' .. vim.fn.expand("%:r") .. ' < input.txt > output.txt 2> error.txt',
    cpp = 'g++ -o file_io ' .. filename .. ' 2> error.txt && ./file_io < input.txt > output.txt 2> error.txt',
    c = 'gcc -o file_io ' .. filename .. ' 2> error.txt && ./file_io < input.txt > output.txt 2> error.txt'
}
    -- Get the command for the current file type
    local command = commands[extension]
    if not command then
        print("Unsupported file type: " .. extension)
        return
    end

    -- Run the command and capture errors
    os.execute(command)

    -- Read error file
    local error_file = io.open("error.txt", "r")
    local errors = error_file and error_file:read("*all") or ""
    if error_file then error_file:close() end

    -- Function to display messages in a floating window


local function show_floating_window(message)
    local buf = vim.api.nvim_create_buf(false, true) -- Create a buffer
    if not buf then
        print("Failed to create buffer")
        return
    end

    local opts = {
        relative = "editor",
        width = 80,
        height = 20,
        row = math.floor((vim.o.lines - 20) / 2),
        col = math.floor((vim.o.columns - 80) / 2),
        style = "minimal",
        border = "rounded"
    }

    local win = vim.api.nvim_open_win(buf, true, opts)
    if not win then
        print("Failed to create floating window")
        return
    end

    -- Set buffer lines
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(message, "\n"))

    -- Apply highlighting (ensure it exists in your colorscheme)
    vim.cmd("highlight FloatingBg guibg=#1e1e2e guifg=#cdd6f4")
    vim.api.nvim_win_set_option(win, "winhl", "Normal:FloatingBg")

    -- Close window with 'q'
    vim.api.nvim_buf_set_keymap(buf, "n", "q", "<Cmd>bd!<CR>", { noremap = true, silent = true })
end



    if errors and errors ~= "" then
        -- Show errors in floating window
        show_floating_window("Errors:\n" .. errors)
        return
    end

    -- Compare output.txt with real_output.txt
    local function read_file(filename)
        local file = io.open(filename, "r")
        if not file then return nil end
        local content = file:read("*all")
        file:close()
        return content
    end

    local output_content = read_file("output.txt")
    local real_output_content = read_file("../.skibidi/real_output.txt")

    if not output_content or not real_output_content then
        show_floating_window("Error: Missing output files")
        return
    end

    -- Split outputs into lines for comparison
    local output_lines = vim.split(output_content, "\n")
    local real_output_lines = vim.split(real_output_content, "\n")

    -- Count the number of matching lines
    local passed = 0
    for i, line in ipairs(output_lines) do
        if line == real_output_lines[i] then
            passed = passed + 1
        end
    end

    -- Calculate the number of test cases
    local total_tests = math.max(#output_lines, #real_output_lines)

    if passed == total_tests then
        show_floating_window("✅ All test cases passed!")
    else
        show_floating_window(string.format("❌ %d/%d test cases passed!\nTry harder!", passed, total_tests))
    end
end

-- Keybinding to run the code and check output
vim.api.nvim_set_keymap("n", "<leader>tt", "", { noremap = true, silent = true, callback = run_code })
