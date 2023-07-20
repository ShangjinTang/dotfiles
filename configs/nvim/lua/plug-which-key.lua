-- Reference: https://github.com/folke/which-key.nvim

local wk = require("which-key")
local normal_mode = { mode = "n" }
local normal_mode_with_expr = { mode = "n", expr = true }
local visual_mode = { mode = "v" }

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global Mappings: both normal mode & visual mode

wk.register({
    ["s"] = { require("substitute").operator, "Substitute Operator" },
    ["ss"] = { require("substitute").line, "Substitute Line" },
    ["S"] = { require("substitute").eol, "Substitute to End of Line" },
}, normal_mode)
wk.register({
    ["s"] = { require("substitute").operator, "Substitute Operator" },
}, visual_mode)

wk.register({
    ["<leader>C"] = { name = "+ChatGPT" },
    ["<leader>Ca"] = { "<cmd>ChatGPTActAs<cr>", "Act as ..." },
    ["<leader>Cc"] = { "<cmd>ChatGPT<cr>", "ChatGPT" },
    ["<leader>Ce"] = { "<cmd>ChatGPTEditWithInstructions<cr>", "Edit with Instructions" },
}, normal_mode)
wk.register({
    ["<leader>C"] = { name = "+ChatGPT" },
    ["<leader>Ce"] = { require("chatgpt").edit_with_instructions, "Edit with Instructions" },
}, visual_mode)

wk.register({
    ["<leader>_"] = { require("osc52").copy_operator, "Copy (osc52)" },
}, normal_mode_with_expr)
wk.register({
    ["<leader>_"] = { "<cmd>lua require('osc52').copy_visual()<cr>", "Copy (osc52)" },
}, visual_mode)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global Mappings: only normal mode

wk.register({
    ["<leader>y"] = { "<cmd>lua require('telescope').extensions.neoclip.default()<cr>", "Yank History (neoclip)" },

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
    ["<leader>Z"] = { "<cmd>ZenMode<cr>", "Zen Mode" },

    ["<leader>a"] = { name = "+AsyncRun & AsyncTasks" },
    ["<leader>aa"] = { "<cmd>lua require('telescope').extensions.asynctasks.all()<cr>", "List All AsyncTasks" },

    ["<leader>bb"] = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },

    ["<leader>E"] = { "<cmd>lua require('lir.float').toggle()<cr>", "Float Explorer" },

    ["<leader>f"] = { name = "+File" },
    ["<leader>ff"] = {
        function()
            require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:h") })
        end,
        "Find File",
    },
    ["<leader>fw"] = {
        function()
            require("telescope.builtin").grep_string({ cwd = vim.fn.expand("%:h") })
        end,
        "Grep Current Word",
    },
    ["<leader>fg"] = {
        function()
            require("telescope.builtin").live_grep({ cwd = vim.fn.expand("%:h") })
        end,
        "Live Grep",
    },
    ["<leader>fr"] = { "<cmd>Telescope oldfiles previewer=true<cr>", "Open Recent File" },
    ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
    ["<leader>ft"] = { "<cmd>Filetypes<cr>", "Set File Type" },

    ["<leader>d"] = { name = "+Dap" },
    -- mostly follow gdb/ldb mappings
    ["<leader>db"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "b(reakpoint)" },
    ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "c(ontinue)" },
    ["<leader>dr"] = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "run to cursor" },
    ["<leader>ds"] = { "<cmd>lua require'dap'.step_into()<cr>", "s(tep) [step into]" },
    ["<leader>dn"] = { "<cmd>lua require'dap'.step_over()<cr>", "n(ext) [step over]" },
    ["<leader>do"] = { "<cmd>lua require'dap'.step_out()<cr>", "finish [step out]" },
    -- DapUI
    ["<leader>dd"] = {
        function()
            require("dap").disconnect()
            require("dapui").toggle({ reset = true })
        end,
        "Disconnect",
    },
    ["<leader>du"] = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle Dap UI" },
    -- Dap + Telescope
    ["<leader>dl"] = {
        function()
            require("telescope").extensions.dap.list_breakpoints({})
        end,
        "Dap list breakpoints",
    },
    ["<leader>dv"] = {
        function()
            require("telescope").extensions.dap.variables({})
        end,
        "Dap variables",
    },
    ["<leader>df"] = {
        function()
            require("telescope").extensions.dap.frames({})
        end,
        "Dap frames",
    },
    ["<leader>D"] = {
        function()
            require("telescope").extensions.dap.commands({})
        end,
        "Dap commands",
    },

    ["<leader>gf"] = {
        function()
            require("lvim.core.telescope.custom-finders").find_project_files({ previewer = false })
        end,
        "Find Git File",
    },
    ["<leader>gd"] = { "<cmd>DiffviewFileHistory<cr>", "Git diff" },
    ["<leader>gD"] = { "<cmd>DiffviewFileHistory %<cr>", "Git diff (for current file)" },
    ["<leader>gt"] = { "<cmd>DiffviewToggleFiles<cr>", "Toggle DiffviewFileHistoryPanel" },
    ["<leader>gL"] = { "<cmd>Git blame<cr>", "Git blame (for all lines)" },

    ["<leader>ld"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Buffer Diagnostics" },
    ["<leader>lt"] = { "<cmd>ToggleDiag<cr>", "Toggle Diagnostics" },
    ["<leader>lD"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },

    ["<leader>o"] = { name = "+Open file with" },
    ["<leader>oc"] = { "<cmd>call ExecuteBufferSilentlyWith('code')<cr>", "Open with VsCode" },
    ["<leader>ow"] = { "<cmd>call ExecuteBufferSilentlyWith('explorer.exe')<cr>", "Open with Windows Explorer" },

    ["<leader>p"] = { name = "+Project" },
    ["<leader>pp"] = { "<cmd>Telescope projects<cr>", "Recent Projects" },
    ["<leader>pf"] = {
        function()
            require("telescope.builtin").find_files({ cwd = require("project_nvim.project").get_project_root() })
        end,
        "Find Project File",
    },
    ["<leader>pw"] = {
        function()
            require("telescope.builtin").grep_string({ cwd = require("project_nvim.project").get_project_root() })
        end,
        "Project Grep Current Word",
    },
    ["<leader>pg"] = {
        function()
            require("telescope.builtin").live_grep({ cwd = require("project_nvim.project").get_project_root() })
        end,
        "Project Live Grep",
    },

    ["<leader>s"] = { name = "+Search & Substitute" },
    ["<leader>sw"] = { name = "Substitute word (from current selection)" },
    ["<leader>sa"] = { name = "Substitute word (from first line)" },
    ["<leader>ss"] = { "<cmd>lua require('spectre').open()<cr>", "Substitute with Spectre" },

    ["<leader>S"] = { "<cmd>SymbolsOutline<cr>", "Symbols Explorer" },

    ["<leader>m"] = { name = "Markdown (Telekasten)" },
    ["<leader>mf"] = { "<cmd>Telekasten find_notes<cr>", "Find Notes" },
    ["<leader>mg"] = { "<cmd>Telekasten search_notes<cr>", "Live Grep in Notes" },
    ["<leader>mt"] = { "<cmd>Telekasten goto_today<cr>", "Goto Today" },
    ["<leader>mw"] = { "<cmd>Telekasten goto_thisweek<cr>", "Goto This Week" },
    ["<leader>mn"] = { "<cmd>Telekasten new_note<cr>", "New Note" },
    ["<leader>mc"] = { "<cmd>Telekasten show_calendar<cr>", "Show calendar" },

    ["zR"] = { require("ufo").openAllFolds, "Open All Folds" },
    ["zM"] = { require("ufo").closeAllFolds, "Close All Folds" },
    ["zr"] = { require("ufo").openFoldsExceptKinds, "Open Folds except Kinds" },
    ["zm"] = { require("ufo").closeFoldsWith, "Close Folds With <num> (e.g. 1zm)" },
}, normal_mode)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Conditional Mappings: FileType

vim.cmd("autocmd FileType * lua set_key_bindings()")
function set_key_bindings()
    local ftype = vim.api.nvim_buf_get_option(0, "filetype")
    local fname = vim.fn.expand("%:t")

    -- markdown
    if ftype == "markdown" then
        wk.register({
            ["<CR>"] = { "<cmd>MkdnEnter<cr>", "Follow or Insert Link / Header Collapse" },
            ["<BS>"] = { "<cmd>MkdnGoBack<cr>", "Go Back" },
            ["<S-Tab>"] = { "<cmd>MkdnPrevLink<cr>", "Previous Link" },
            ["<Tab>"] = { "<cmd>MkdnNextLink<cr>", "Next Link" },
            ["[["] = { "<cmd>MkdnPrevHeading<cr>", "Previous Heading" },
            ["]]"] = { "<cmd>MkdnNextHeading<cr>", "Next Heading" },
            ["o"] = { "<cmd>MkdnNewListItemBelowInsert<cr>", "Insert Below (list-supported)" },
            ["O"] = { "<cmd>MkdnNewListItemAboveInsert<cr>", "Insert Above (list-supported)" },
            ["H"] = { "<cmd>MkdnTablePrevCell<cr>", "Table - Previous Cell" },
            ["L"] = { "<cmd>MkdnTableNextCell<cr>", "Table - Next Cell" },
            ["<leader>m"] = { name = "Markdown & Telekasten" },
            ["<leader>mm"] = { "<cmd>Telekasten panel<cr>", "Telekasten Panel" },
            ["<leader>ms"] = { "<cmd>FeMaco<cr>", "Edit Code Snippet" },
            ["<leader>mp"] = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle Preview" },
            ["<leader>mx"] = { "<cmd>MkdnToggleToDo<cr>", "Toggle Todo" },
            ["<leader>mr"] = { "<cmd>MkdnMoveSource<cr>", "Rename Source in Link" },
            ["<leader>mb"] = { "<cmd>Telekasten show_backlinks<cr>", "Show backlinks" },
            ["<leader>mi"] = { name = "+Insert" },
            ["<leader>mit"] = { "<cmd>MkdnTable 3 2<cr>", "Insert Table" },
            ["<leader>miR"] = { "<cmd>MkdnTableNewRowAbove<cr>", "Insert Row Above" },
            ["<leader>mir"] = { "<cmd>MkdnTableNewRowBelow<cr>", "Insert Row Below" },
            ["<leader>miC"] = { "<cmd>MkdnTableNewColBefore<cr>", "Insert Col Left" },
            ["<leader>mic"] = { "<cmd>MkdnTableNewColAfter<cr>", "Insert Col Right" },
            ["<leader>mil"] = { "<cmd>Telekasten insert_link<cr>", "Insert link" },
            ["<leader>mii"] = { "<cmd>Telekasten insert_img_link<cr>", "Insert img link" },
        }, normal_mode)
        wk.register({
            ["<CR>"] = { "<cmd>MkdnEnter<cr>", "Follow or Insert Link / Header Collapse" },
        }, visual_mode)
    end

    -- program: c / cpp / python / sh / zsh
    -- as: AsyncRun Code: Snippet / Single File
    if ftype == "c" then
        wk.register({
            ["<leader>as"] = { "<cmd>call ExecuteBufferWith('rc --clean_output')<cr>", "Run (buffer)" },
        }, normal_mode)
    elseif ftype == "cpp" then
        wk.register({
            ["<leader>as"] = { "<cmd>call ExecuteBufferWith('rcxx --clean_output')<cr>", "Run (buffer)" },
        }, normal_mode)
    elseif ftype == "java" then
        wk.register({
            ["<leader>as"] = { "<cmd>call ExecuteBufferWith('java')<cr>", "Run (buffer)" },
        }, normal_mode)
    elseif ftype == "python" then
        wk.register({
            ["<leader>as"] = { "<cmd>call ExecuteBufferWith('python')<cr>", "Run (buffer)" },
        }, normal_mode)
    elseif ftype == "sh" or ftype == "bash" then
        wk.register({
            ["<leader>as"] = { "<cmd>call ExecuteBufferWith('bash')<cr>", "Run (buffer)" },
        }, normal_mode)
    elseif ftype == "zsh" then
        wk.register({
            ["<leader>as"] = { "<cmd>call ExecuteBufferWith('zsh')<cr>", "Run (buffer)" },
        }, normal_mode)
    end

    -- project: cmake / cargo
    if ftype == "c" or ftype == "cpp" or fname == "CMakeLists.txt" then
        wk.register({
            ["<leader>ab"] = { "<cmd>call ExecuteInRootWith('cmakebuild -t all')<cr>", "Project Build [CMake]" },
            ["<leader>ar"] = { "<cmd>call ExecuteInRootWith('cmakebuild -t run')<cr>", "Project Run [CMake]" },
        }, normal_mode)
    elseif ftype == "rust" or fname == "Cargo.toml" then
        wk.register({
            ["<leader>ab"] = { "<cmd>call ExecuteInRootWith('cargo build')<cr>", "Project Build [Cargo]" },
            ["<leader>ar"] = { "<cmd>call ExecuteInRootWith('cargo run')<cr>", "Project Run [Cargo]" },
        }, normal_mode)
    end

    -- cscope_maps.nvim
    if ftype == "c" or ftype == "cpp" or ftype == "java" then
        wk.register({
            ["<leader>c"] = { name = "Cscope" },
            ["<leader>cs"] = {
                function()
                    vim.api.nvim_command("Cscope find s " .. vim.fn.expand("<cword>"))
                end,
                "Find this symbol",
            },
            ["<leader>cg"] = {
                function()
                    vim.api.nvim_command("Cscope find g " .. vim.fn.expand("<cword>"))
                end,
                "Find this global definition",
            },
            ["<leader>cd"] = {
                function()
                    vim.api.nvim_command("Cscope find d " .. vim.fn.expand("<cword>"))
                end,
                "Find functions called by this function",
            },
            ["<leader>cc"] = {
                function()
                    vim.api.nvim_command("Cscope find c " .. vim.fn.expand("<cword>"))
                end,
                "Find functions calling this function",
            },
            ["<leader>ct"] = {
                function()
                    vim.api.nvim_command("Cscope find t " .. vim.fn.expand("<cword>"))
                end,
                "Find this text string",
            },
            ["<leader>ce"] = {
                function()
                    vim.api.nvim_command("Cscope find e " .. vim.fn.expand("<cword>"))
                end,
                "Find this egrep pattern",
            },
            ["<leader>cf"] = {
                function()
                    vim.api.nvim_command("Cscope find f " .. vim.fn.expand("<cword>"))
                end,
                "Find this file",
            },
            ["<leader>ci"] = {
                function()
                    vim.api.nvim_command("Cscope find i " .. vim.fn.expand("<cword>"))
                end,
                "Find files #including this file",
            },
            ["<leader>ca"] = {
                function()
                    vim.api.nvim_command("Cscope find a " .. vim.fn.expand("<cword>"))
                end,
                "Find assignments to this symbol",
            },
            ["<leader>cb"] = { "<cmd>Cscope build<cr>", "build cscope database" },
            -- ["Ctrl-]"] = {
            --     function()
            --         vim.api.nvim_command("Cstag" .. vim.fn.expand("<cword>"))
            --     end,
            --     "Cstag find this symbol",
            -- },
        })
    end

    -- for telekasten calendar; do not use default 'BufferKill' would open next buffer
    if ftype == "calendar" then
        wk.register({
            ["<leader>w"] = { "<cmd>bd<cr>", "Close Current Buffer" },
        }, normal_mode)
    end
end
