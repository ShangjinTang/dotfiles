-- Reference: https://github.com/folke/which-key.nvim

local wk = require("which-key")
local normal_mode = { mode = "n" }
local visual_mode = { mode = "v" }

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global Mappings: both normal mode & visual mode

wk.register({
    ["s"] = { require('substitute').operator, "Substitute Operator" },
    ["ss"] = { require('substitute').line, "Substitute Line" },
    ["S"] = { require('substitute').eol, "Substitute to End of Line" },
}, normal_mode)
wk.register({
    ["s"] = { require('substitute').operator, "Substitute Operator" },
}, visual_mode)


wk.register({
    ["<leader>c"] = { name = "+ChatGPT" },
    ["<leader>ca"] = { "<cmd>ChatGPTActAs<cr>", "Act as ..." },
    ["<leader>cc"] = { "<cmd>ChatGPT<cr>", "ChatGPT" },
    ["<leader>ce"] = { "<cmd>ChatGPTEditWithInstructions<cr>", "Edit with Instructions" },
}, normal_mode)
wk.register({
    ["<leader>c"] = { name = "+ChatGPT" },
    ["<leader>ce"] = { require('chatgpt').edit_with_instructions, "Edit with Instructions" },
}, visual_mode)



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global Mappings: only normal mode

wk.register({
    ["<leader>y"] = { "<cmd>Telescope yank_history<cr>", "Yank History" },

    ["<C-p>"] = { "<cmd>Telescope lsp_definitions<cr>", "Goto Definition" },
    ["K"] = { vim.lsp.buf.hover, "Hover" },
    ["gd"] = { "<cmd>Telescope lsp_definitions<cr>", "Goto Definition" },
    ["gi"] = { "<cmd>Telescope lsp_implementations<cr>", "Goto Implementation" },
    ["gt"] = { "<cmd>Telescope lsp_type_definitions<cr>", "Goto Type Definition" },
    ["gr"] = { "<cmd>Telescope lsp_references<cr>", "Goto References" },

    ["<leader>["] = { "<cmd>BufferLineCyclePrev<cr>", "Previous Buffer" },
    ["<leader>]"] = { "<cmd>BufferLineCycleNext<cr>", "Next Buffer" },
    ["<leader><tab>"] = { "<cmd>b#<cr>", "Switch between buffers" },
    ["<leader>q"] = { "<cmd>qa!<cr>", "Force Quit All Buffers" },
    ["<leader>w"] = { "<cmd>BufferKill<cr>", "Close Current Buffer" },
    ["<leader>z"] = { "<cmd>ZenMode<cr>", "Zen Mode" },

    ["<leader>a"] = { name = "+AsyncRun/AsyncTasks" },
    ["<leader>aa"] = { "<cmd>lua require('telescope').extensions.asynctasks.all()<cr>", "List All AsyncTasks" },
    ["<leader>aq"] = { "<cmd>VimuxCloseRunner<cr>", "Quit Async Window" },

    ["<leader>bb"] = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },

    ["<leader>E"] = { "<cmd>SymbolsOutline<cr>", "Symbols Explorer" },

    ["<leader>f"] = { name = "+File" },
    ["<leader>ff"] = { "<cmd>Telescope find_files previewer=false<cr>", "Find File" },
    ["<leader>fw"] = { "<cmd>Telescope grep_string<cr>", "File Grep Current Word" },
    ["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", "File Live Grep" },
    ["<leader>fr"] = { "<cmd>Telescope oldfiles previewer=true<cr>", "Open Recent File" },
    ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },

    ["<leader>d"] = { name = "+Dap" },
    -- mostly follow gdb/ldb mappings
    ["<leader>db"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "b(reakpoint)" },
    ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "c(ontinue)" },
    ["<leader>dr"] = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "run to cursor" },
    ["<leader>ds"] = { "<cmd>lua require'dap'.step_into()<cr>", "s(tep) [step into]" },
    ["<leader>dn"] = { "<cmd>lua require'dap'.step_over()<cr>", "n(ext) [step over]" },
    ["<leader>do"] = { "<cmd>lua require'dap'.step_out()<cr>", "finish [step out]" },
    -- DapUI
    ["<leader>dd"] = { function()
        require 'dap'.disconnect()
        require 'dapui'.toggle({ reset = true })
    end, "Disconnect" },
    ["<leader>du"] = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle Dap UI" },
    -- Dap + Telescope
    ["<leader>dl"] = { function() require 'telescope'.extensions.dap.list_breakpoints {} end, "Dap list breakpoints" },
    ["<leader>dv"] = { function() require 'telescope'.extensions.dap.variables {} end, "Dap variables" },
    ["<leader>df"] = { function() require 'telescope'.extensions.dap.frames {} end, "Dap frames" },
    ["<leader>D"] = { function() require 'telescope'.extensions.dap.commands {} end, "Dap commands" },

    ["<leader>gf"] = {
        function()
            require("lvim.core.telescope.custom-finders").find_project_files { previewer = false }
        end,
        "Find Git File",
    },
    ["<leader>gd"] = { "<cmd>DiffviewFileHistory<cr>", "Git diff" },
    ["<leader>gD"] = { "<cmd>DiffviewFileHistory %<cr>", "Git diff (for current file)" },
    ["<leader>gt"] = { "<cmd>DiffviewToggleFiles<cr>", "Toggle DiffviewFileHistoryPanel" },
    ["<leader>gL"] = { "<cmd>Git blame<cr>", "Git blame (for all lines)" },

    ["<leader>ld"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Buffer Diagnostics" },
    ["<leader>lD"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },

    ["<leader>n"] = { name = "+Norg" },
    ["<leader>nd"] = { "<cmd>Neorg journal today<cr>", "New Diary" },
    ["<leader>nn"] = { "<cmd>Neorg keybind all core.dirman.new.note<cr>", "New Note" },
    ["<leader>ni"] = { "<cmd>Neorg index<cr>", "Open Index" },
    ["<leader>nq"] = { "<cmd>Neorg return<cr>", "Quit" },

    ["<leader>o"] = { name = "+Open file with" },
    ["<leader>oc"] = { "<cmd>call ExecuteBufferSilentlyWith('code')<cr>", "Open with VsCode" },
    ["<leader>ow"] = { "<cmd>call ExecuteBufferSilentlyWith('explorer.exe')<cr>", "Open with Windows Explorer" },

    ["<leader>p"] = { name = "+Project" },
    ["<leader>pp"] = { "<cmd>Telescope projects<cr>", "Recent Projects" },
    ["<leader>pf"] = {
        function()
            require("telescope.builtin").find_files({ cwd = vim.api.nvim_eval('FindRootDirectory()') })
        end,
        "Find Project File",
    },
    ["<leader>pw"] = {
        function()
            require("telescope.builtin").grep_string({ cwd = vim.api.nvim_eval('FindRootDirectory()') })
        end,
        "Project Grep Current Word",
    },
    ["<leader>pg"] = {
        function()
            require("telescope.builtin").live_grep({ cwd = vim.api.nvim_eval('FindRootDirectory()') })
        end,
        "Project Live Grep",
    },

    ["<leader>S"] = { name = "+substitute" },
    ["<leader>Sw"] = { name = "word substitute (from current selection)" },
    ["<leader>SW"] = { name = "word substitute (from first line)" },
    ["<leader>Ss"] = { "<cmd>lua require('spectre').open_file_search()<cr>", "Spectre (file)" },
    ["<leader>SS"] = { "<cmd>lua require('spectre').open()<cr>", "Spectre (vim directory)" },
})



--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Conditional Mappings: FileType

vim.cmd('autocmd FileType * lua set_key_bindings()')
function set_key_bindings()
    local ftype = vim.api.nvim_buf_get_option(0, "filetype")
    local fname = vim.fn.expand("%:t")

    -- norg / markdown
    if ftype == 'norg' then
        wk.register({
            ["<leader>ns"] = { "<cmd>Neorg keybind all core.looking-glass.magnify-code-block<cr>",
                "Edit Selected Snippet" },
            ["<leader>nj"] = { "<cmd>Neorg keybind all core.integrations.treesitter.next.heading<cr>", "Next Heading" },
            ["<leader>nk"] = { "<cmd>Neorg keybind all core.integrations.treesitter.previous.heading<cr>",
                "Previous Heading" },
            ["<leader>nh"] = { "<cmd>Neorg inject-metadata<cr>", "Inject Metadata" },
            ["<leader>nH"] = { "<cmd>Neorg update-metadata<cr>", "Update Metadata" },
            ["<leader>nm"] = {
                "<cmd>execute 'Neorg export to-file ' .. expand('%:p:r') .. '.md' | sleep 100m | execute 'e ' .. expand('%:p:r') .. '.md'<cr>",
                "Export to Markdown" },
            ["<C-n>"] = { "<cmd>Neorg keybind all core.qol.todo_items.todo.task_cycle<cr>", "Task Cycle" },
        }, normal_mode)
    elseif ftype == 'markdown' then
        wk.register({
            ["<leader>m"] = { name = "+Markdown" },
            ["<leader>ms"] = { "<cmd>FeMaco<cr>", "Edit Selected Snippet" },
            ["<leader>mp"] = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview" },
        }, normal_mode)
    end

    -- program: c / cpp / python / sh / zsh
    -- as: AsyncRun Single
    if ftype == 'c' then
        wk.register({
            ["<leader>as"] = { "<cmd>call ExecuteBufferWith('rc --clean_output')<cr>", "Run (buffer)" },
        }, normal_mode)
    elseif ftype == 'cpp' then
        wk.register({
            ["<leader>as"] = { "<cmd>call ExecuteBufferWith('rcxx --clean_output')<cr>", "Run (buffer)" },
        }, normal_mode)
    elseif ftype == 'python' then
        wk.register({
            ["<leader>as"] = { "<cmd>call ExecuteBufferWith('python')<cr>", "Run (buffer)" },
        }, normal_mode)
    elseif ftype == 'sh' or ftype == 'bash' then
        wk.register({
            ["<leader>as"] = { "<cmd>call ExecuteBufferWith('bash')<cr>", "Run (buffer)" },
        }, normal_mode)
    elseif ftype == 'zsh' then
        wk.register({
            ["<leader>as"] = { "<cmd>call ExecuteBufferWith('zsh')<cr>", "Run (buffer)" },
        }, normal_mode)
    end

    -- project: cmake / cargo
    if ftype == 'c' or ftype == 'cpp' or fname == 'CMakeLists.txt' then
        wk.register({
            ["<leader>ab"] = { "<cmd>call ExecuteInRootWith('cmakebuild -t all')<cr>", "Project Build [CMake]" },
            ["<leader>ar"] = { "<cmd>call ExecuteInRootWith('cmakebuild -t run')<cr>", "Project Run [CMake]" },
        }, normal_mode)
    elseif ftype == 'rust' or fname == 'Cargo.toml' then
        wk.register({
            ["<leader>ab"] = { "<cmd>call ExecuteInRootWith('cargo build')<cr>", "Project Build [Cargo]" },
            ["<leader>ar"] = { "<cmd>call ExecuteInRootWith('cargo run')<cr>", "Project Run [Cargo]" },
        }, normal_mode)
    end
end
