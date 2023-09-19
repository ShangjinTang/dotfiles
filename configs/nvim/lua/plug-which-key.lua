-- Reference: https://github.com/folke/which-key.nvim

local wk = require("which-key")
local normal_mode = { mode = "n" }
local normal_mode_with_expr = { mode = "n", expr = true }
local visual_mode = { mode = "v" }

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global Mappings: both normal mode & visual mode

wk.register({
    ["s"] = { "<cmd>lua require('substitute').operator()<cr>", "Substitute Operator" },
    ["ss"] = { "<cmd>lua require('substitute').line()<cr>", "Substitute Line" },
    ["S"] = { "<cmd>lua require('substitute').eol()<cr>", "Substitute to End of Line" },
}, normal_mode)
wk.register({
    ["s"] = { "<cmd>lua require('substitute').operator()<cr>", "Substitute Operator" },
}, visual_mode)

-- wk.register({
--     ["<leader>C"] = { "<cmd>ChatGPT<cr>", "ChatGPT Prompt" },
--     ["<leader>c"] = { name = "+ChatGPT Commands" },
--     ["<leader>ca"] = { "<cmd>ChatGPTActAs<cr>", "Act as ..." },
--     ["<leader>cc"] = { "<cmd>ChatGPTEditWithInstructions<cr>", "Edit with Instructions" },
--     -- Code Edit / Replace / Append
--     ["<leader>ct"] = { "<cmd>ChatGPTRun add_tests<cr>", "Add Code Tests" },
--     ["<leader>cd"] = { "<cmd>ChatGPTRun docstring<cr>", "Add Code Docs" },
--     ["<leader>cg"] = { "<cmd>ChatGPTRun complete_code<cr>", "Code Generate" },
--     ["<leader>cf"] = { "<cmd>ChatGPTRun fix_bugs<cr>", "Code Fix" },
--     ["<leader>co"] = { "<cmd>ChatGPTRun optimize_code<cr>", "Code Optimize" },
--     -- Display
--     ["<leader>ce"] = { "<cmd>ChatGPTRun explain_code<cr>", "Code Explain" },
--     -- Chat
--     ["<leader>ck"] = { "<cmd>ChatGPTRun keywords<cr>", "Keywords" },
--     ["<leader>cr"] = { "<cmd>ChatGPTRun explain_code<cr>", "Code Readability Analysis" },
-- }, normal_mode)
-- wk.register({
--     ["<leader>C"] = { "<cmd>ChatGPT<cr>", "ChatGPT Prompt" },
--     ["<leader>c"] = { name = "+ChatGPT Commands" },
--     ["<leader>ca"] = { "<cmd>ChatGPTActAs<cr>", "Act as ..." },
--     ["<leader>cc"] = { "<cmd>ChatGPTEditWithInstructions<cr>", "Edit with Instructions" },
--     -- Code Edit / Replace / Append
--     ["<leader>ct"] = { "<cmd>ChatGPTRun add_tests<cr>", "Add Code Tests" },
--     ["<leader>cd"] = { "<cmd>ChatGPTRun docstring<cr>", "Add Code Docs" },
--     ["<leader>cg"] = { "<cmd>ChatGPTRun complete_code<cr>", "Code Generate" },
--     ["<leader>cf"] = { "<cmd>ChatGPTRun fix_bugs<cr>", "Code Fix" },
--     ["<leader>co"] = { "<cmd>ChatGPTRun optimize_code<cr>", "Code Optimize" },
--     -- Display
--     ["<leader>ce"] = { "<cmd>ChatGPTRun explain_code<cr>", "Code Explain" },
--     -- Chat
--     ["<leader>ck"] = { "<cmd>ChatGPTRun keywords<cr>", "Keywords" },
--     ["<leader>cr"] = { "<cmd>ChatGPTRun explain_code<cr>", "Code Readability Analysis" },
-- }, visual_mode)

wk.register({
    ["<leader>_"] = { "<cmd>lua require('osc52').copy_operator()<cr>", "Copy (osc52)" },
}, normal_mode_with_expr)
wk.register({
    ["<leader>_"] = { "<cmd>lua require('osc52').copy_visual()<cr>", "Copy (osc52)" },
}, visual_mode)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global Mappings: only normal mode

wk.register({
    ["<C-b>"] = { "Scroll Backward (1 Screen)" },
    ["<C-f>"] = { "Scroll Forward (1 Screen)" },
    ["<C-u>"] = { "Scroll Up (1/2 Screen)" },
    ["<C-d>"] = { "Scroll Down (1/2 Screen)" },
    ["<C-y>"] = { "Scroll Up (a few lines)" },
    ["<C-e>"] = { "Scroll Down (a few lines)" },

    ["<S-Left>"] = {
        '<Cmd>lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>H", true, true, true), "n", true)<CR>',
        "Window: Move to left",
    },
    ["<S-Right>"] = {
        '<Cmd>lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>L", true, true, true), "n", true)<CR>',
        "Window: Move to right",
    },
    ["<S-Up>"] = {
        '<Cmd>lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>K", true, true, true), "n", true)<CR>',
        "Window: Move to top",
    },
    ["<S-Down>"] = {
        '<Cmd>lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>J", true, true, true), "n", true)<CR>',
        "Window: Move to bottom",
    },
    -- [""] = {
    --     '<Cmd>lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>T", true, true, true), "n", true)<CR>',
    --     "Window: Move to new tab",
    -- },

    ["<leader>y"] = { "<cmd>lua require('telescope').extensions.neoclip.default()<cr>", "Yank History (neoclip)" },
    ["<C-p>"] = { "<cmd>Telescope lsp_definitions<cr>", "Goto Definition" },
    ["K"] = {
        function()
            -- vim.lsp.buf.hover()
            vim.api.nvim_command("Lspsaga hover_doc")
        end,
        "Hover",
    },

    ["["] = { name = "+Prev" },
    ["]"] = { name = "+Next" },
    ["[g"] = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
    ["]g"] = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
    ["[d"] = {
        -- "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded' }})<cr>",
        "<cmd>Lspsaga diagnostic_jump_prev<cr>",
        "Prev Diagnostic",
    },
    ["]d"] = {
        -- "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded' }})<cr>",
        "<cmd>Lspsaga diagnostic_jump_next<cr>",
        "Next Diagnostic",
    },
    ["[t"] = { "<cmd>lua require('todo-comments').jump_prev()<cr>", "Prev Todo-Comment" },
    ["]t"] = { "<cmd>lua require('todo-comments').jump_next()<cr>", "Next Todo-Comment" },
    ["[m"] = { "<cmd>BookmarkPrev<cr>", "Prev Bookmark" },
    ["]m"] = { "<cmd>BookmarkNext<cr>", "Next Bookmark" },

    -- ["gd"] = { "<cmd>Telescope lsp_definitions<cr>", "Goto Definition" },
    ["gd"] = { "<cmd>Lspsaga peek_definition<cr>", "Lspsaga Peek Definition" },
    ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto Declaration" },
    ["gr"] = { "<cmd>Telescope lsp_references<cr>", "Goto References" },
    ["gI"] = { "<cmd>Telescope lsp_implementations<cr>", "Goto Implementation" },
    ["gs"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "show signature help" },
    ["L"] = { "<cmd>Lspsaga finder tyd+def+ref+imp<cr>", "Lspsaga Finder" },
    -- ["gt"] = { "<cmd>Telescope lsp_type_definitions<cr>", "Goto Type Definition" },
    ["gt"] = { "<cmd>Lspsaga peek_type_definition<cr>", "Lspsaga Peek Type Definition" },

    ["mm"] = { "<cmd>BookmarkToggle<cr>", "Bookmark Toggle" },
    ["ma"] = { "<cmd>BookmarkShowAll<cr>", "Bookmark Show All" },
    ["mi"] = { "<cmd>BookmarkAnnotate<cr>", "Bookmark Annotate" },
    ["mx"] = { "<cmd>BookmarkClearAll<cr>", "Bookmark Clear All" },
    ["mc"] = { "<cmd>BookmarkClear<cr>", "Bookmark Clear" },

    ["<leader>["] = { "<cmd>BufferLineCyclePrev<cr>", "Previous Buffer" },
    ["<leader>]"] = { "<cmd>BufferLineCycleNext<cr>", "Next Buffer" },
    ["<leader><tab>"] = { "<cmd>b#<cr>", "Switch between buffers" },
    ["<leader>q"] = { "<cmd>qa!<cr>", "Force Quit All Buffers" },
    ["<leader>w"] = { "<cmd>BufferKill<cr>", "Close Current Buffer" },
    ["<leader>z"] = { "<cmd>lua require('telescope').extensions.zoxide.list({})<cr>", "Zoxide" },
    ["<leader>Z"] = { "<cmd>ZenMode<cr>", "Zen Mode" },

    ["<leader>a"] = { name = "+AsyncRun & AsyncTasks" },
    ["<leader>aa"] = { "<cmd>lua require('telescope').extensions.asynctasks.all()<cr>", "List All AsyncTasks" },
    ["<leader>al"] = { "<cmd>AsyncTaskLast<cr>", "Run Last AsyncTask" },
    ["<leader>aq"] = { "<cmd>VimuxCloseRunner<cr>", "Quit AsyncTask Window (TMUX)" },

    ["<leader>bb"] = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },

    ["<leader>f"] = { name = "+File" },
    ["<leader>ff"] = {
        function()
            require("telescope.builtin").find_files({
                cwd = vim.fn.expand("%:h"),
                prompt_title = "Find Folder Files",
                previewer = false,
            })
        end,
        "Find Folder Files",
    },
    ["<leader>fw"] = {
        function()
            require("telescope.builtin").grep_string({
                cwd = vim.fn.expand("%:h"),
                prompt_title = "Find Folder Current Word",
                previewer = true,
            })
        end,
        "Find Folder Current Word",
    },
    ["<leader>fg"] = {
        function()
            require("telescope.builtin").live_grep({
                cwd = vim.fn.expand("%:h"),
                prompt_title = "Folder Grep",
                previewer = true,
            })
        end,
        "Folder Grep",
    },
    ["<leader>fr"] = { "<cmd>Telescope oldfiles previewer=true<cr>", "Open Recent File" },
    ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
    ["<leader>ft"] = { "<cmd>Filetypes<cr>", "Set File Type" },

    ["<leader>d"] = { name = "+Dap" },
    ["<leader>dd"] = {
        function()
            require("telescope").extensions.dap.commands({})
        end,
        "Dap commands",
    },
    -- mostly follow gdb/ldb mappings
    ["<leader>db"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "b(reakpoint)" },
    ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "c(ontinue)" },
    ["<leader>dr"] = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "run to cursor" },
    ["<leader>ds"] = { "<cmd>lua require'dap'.step_into()<cr>", "s(tep) [step into]" },
    ["<leader>dn"] = { "<cmd>lua require'dap'.step_over()<cr>", "n(ext) [step over]" },
    ["<leader>do"] = { "<cmd>lua require'dap'.step_out()<cr>", "finish [step out]" },
    -- DapUI
    ["<leader>dq"] = {
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

    ["<leader>E"] = { "<cmd>SymbolsOutline<cr>", "Symbols Explorer" },

    ["<leader>gf"] = {
        function()
            require("lvim.core.telescope.custom-finders").find_project_files({
                prompt_title = "Find Git Files",
                previewer = false,
            })
        end,
        "Find Git Files",
    },

    ["<leader>gd"] = { "<cmd>DiffviewOpen<cr>", "Diffview Open" },
    ["<leader>gD"] = { "<cmd>DiffviewClose<cr>", "Diffview Close" },
    ["<leader>gh"] = { "<cmd>DiffviewFileHistory %<cr>", "Diffview History - Current File" },
    ["<leader>gH"] = { "<cmd>DiffviewFileHistory<cr>", "Diffview History - All Files" },
    ["<leader>g<Tab>"] = { "<cmd>DiffviewToggleFiles<cr>", "Diffview Toggle Files" },
    ["<leader>gL"] = { "<cmd>Git blame<cr>", "Git blame (for all lines)" },
    ["<leader>gv"] = { "<cmd>lua require('gitsigns').toggle_current_line_blame()<cr>", "Toggle virtual text" },

    ["<leader>ld"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Buffer Diagnostics" },
    ["<leader>lt"] = { "<cmd>ToggleDiag<cr>", "Toggle on/off Default Diagnostics" },
    ["<leader>lT"] = { "<cmd>ToggleDiagOn<cr>", "Toggle on All Diagnostics" },
    ["<leader>lD"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },

    ["<leader>o"] = { name = "+Open with" },
    ["<leader>oc"] = { "<cmd>call ExecuteBufferSilentlyWith('code')<cr>", "Open with VsCode" },
    ["<leader>ow"] = { "<cmd>call ExecuteBufferSilentlyWith('explorer.exe')<cr>", "Open with Windows Explorer" },
    ["<leader>oo"] = { "<cmd>lua require('oil').open()<cr>", "Open directory with Oil" },

    ["<leader>p"] = { name = "+Project" },
    ["<leader>pp"] = { "<cmd>Telescope projects<cr>", "Recent Projects" },
    ["<leader>pf"] = {
        function()
            require("telescope.builtin").find_files({
                cwd = require("project_nvim.project").get_project_root(),
                prompt_title = "Find Project Files",
                previewer = false,
            })
        end,
        "Find Project Files",
    },
    ["<leader>pw"] = {
        function()
            require("telescope.builtin").grep_string({
                cwd = require("project_nvim.project").get_project_root(),
                prompt_title = "Find Project Current Word",
                previewer = true,
            })
        end,
        "Find Project Current Word",
    },
    ["<leader>pg"] = {
        function()
            require("telescope.builtin").live_grep({
                cwd = require("project_nvim.project").get_project_root(),
                prompt_title = "Project Grep",
                previewer = true,
            })
        end,
        "Project Grep",
    },

    ["<leader>s"] = { name = "+Search & Substitute" },
    ["<leader>sw"] = { "Substitute word (from current selection)" },
    ["<leader>sa"] = { "Substitute word (from first line)" },
    ["<leader>ss"] = { "<cmd>lua require('spectre').open()<cr>", "Substitute with Spectre" },

    ["<leader>m"] = { name = "+Markdown (Telekasten)" },
    ["<leader>mf"] = { "<cmd>Telekasten find_notes<cr>", "Find Notes" },
    ["<leader>mg"] = { "<cmd>Telekasten search_notes<cr>", "Live Grep in Notes" },
    ["<leader>mt"] = { "<cmd>Telekasten goto_today<cr>", "Goto Today" },
    ["<leader>mw"] = { "<cmd>Telekasten goto_thisweek<cr>", "Goto This Week" },
    ["<leader>mn"] = { "<cmd>Telekasten new_note<cr>", "New Note" },
    ["<leader>mc"] = { "<cmd>Telekasten show_calendar<cr>", "Show calendar" },

    ["z"] = { name = "+Fold / Redraw" },
    ["zo"] = { "Open Fold" },
    ["zO"] = { "Open Folds Recursively" },
    ["zc"] = { "Close Fold" },
    ["zC"] = { "Close Folds Recursively" },
    ["za"] = { "Toggle Fold" },
    ["zA"] = { "Toggle Folds Recursively" },
    ["zd"] = { "Delete Fold (enforce open)" },
    ["zD"] = { "Delete All Folds (enforece open)" },
    ["zj"] = { "Move down to begin of next fold" },
    ["zk"] = { "Move up to end of previous fold" },
    ["zn"] = { "Disable Fold (enforce open)" },
    ["zN"] = { "Enable Fold (enforce fold)" },
    ["zv"] = { "View Current Fold" },
    ["zx"] = { "Reset Fold and View Current Fold (apply 'foldlevel')" },
    ["zX"] = { "Reset Fold (apply 'foldlevel')" },
    ["zm"] = { "<cmd>lua require('ufo').closeFoldsWith()<cr>", "Close All Folds (level prefix-num or 0)" },
    ["zM"] = { "<cmd>lua require('ufo').closeAllFolds()<cr>", "Close All Folds (level 0)" },
    ["zr"] = { "<cmd>lua require('ufo').openFoldsExceptKinds()<cr>", "Open Folds except Kinds (foldlevel max)" },
    ["zR"] = { "<cmd>lua require('ufo').openAllFolds()<cr>", "Open All Folds (level max)" },
    ["zt"] = { "Top Redraw" },
    -- ["z<CR>"] = { "Top Redraw (cursor move to '^')" },
    ["zz"] = { "Center Redraw" },
    -- ["z."] = { "Center Redraw (cursor move to '^')" },
    ["zb"] = { "Bottom Redraw" },
    -- ["z-"] = { "Bottom Redraw (cursor move to '^')" },
}, normal_mode)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Global Mappings: only visual mode

wk.register({
    ["<Bslash>"] = { "<Plug>SnipRun", "SnipRun" },
}, visual_mode)

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
            ["<leader>mk"] = { "<cmd>MkdnPrevHeading<cr>", "Prev Heading" },
            ["<leader>mj"] = { "<cmd>MkdnNextHeading<cr>", "Next Heading" },
            ["<leader>mo"] = { "<cmd>MkdnNewListItemBelowInsert<cr>", "Insert Below (list-supported)" },
            ["<leader>mO"] = { "<cmd>MkdnNewListItemAboveInsert<cr>", "Insert Above (list-supported)" },
            ["<leader>mh"] = { "<cmd>MkdnTablePrevCell<cr>", "Table - Previous Cell" },
            ["<leader>ml"] = { "<cmd>MkdnTableNextCell<cr>", "Table - Next Cell" },
            ["<leader>m"] = { name = "+Markdown & Telekasten" },
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
            ["<Bslash>"] = { name = "+Cscope" },
            ["<Bslash>s"] = {
                function()
                    vim.api.nvim_command("Cscope find s " .. vim.fn.expand("<cword>"))
                end,
                "Find this symbol",
            },
            ["<Bslash>g"] = {
                function()
                    vim.api.nvim_command("Cscope find g " .. vim.fn.expand("<cword>"))
                end,
                "Find this global definition",
            },
            ["<Bslash>d"] = {
                function()
                    vim.api.nvim_command("Cscope find d " .. vim.fn.expand("<cword>"))
                end,
                "Find functions called by this function",
            },
            ["<Bslash>c"] = {
                function()
                    vim.api.nvim_command("Cscope find c " .. vim.fn.expand("<cword>"))
                end,
                "Find functions calling this function",
            },
            ["<Bslash>t"] = {
                function()
                    vim.api.nvim_command("Cscope find t " .. vim.fn.expand("<cword>"))
                end,
                "Find this text string",
            },
            ["<Bslash>e"] = {
                function()
                    vim.api.nvim_command("Cscope find e " .. vim.fn.expand("<cword>"))
                end,
                "Find this egrep pattern",
            },
            ["<Bslash>f"] = {
                function()
                    vim.api.nvim_command("Cscope find f " .. vim.fn.expand("<cword>"))
                end,
                "Find this file",
            },
            ["<Bslash>i"] = {
                function()
                    vim.api.nvim_command("Cscope find i " .. vim.fn.expand("<cword>"))
                end,
                "Find files #including this file",
            },
            ["<Bslash>a"] = {
                function()
                    vim.api.nvim_command("Cscope find a " .. vim.fn.expand("<cword>"))
                end,
                "Find assignments to this symbol",
            },
            ["<Bslash>b"] = { "<cmd>Cscope build<cr>", "build cscope database" },
            -- ["Ctrl-]"] = {
            --     function()
            --         vim.api.nvim_command("Cstag" .. vim.fn.expand("<cword>"))
            --     end,
            --     "Cstag find this symbol",
            -- },
        })
    end

    if ftype == "c" or ftype == "cpp" then
        wk.register({
            ["g<Tab>"] = { "<cmd>Ouroboros<cr>", "Switch .h <-> .c/.cpp" },
        })
    end

    -- for telekasten calendar: do not use default 'BufferKill' would open next buffer
    -- for oil: ’BufferKill’ not work
    if ftype == "calendar" or ftype == "oil" then
        wk.register({
            ["<leader>w"] = { "<cmd>bd<cr>", "Close Current Buffer" },
        }, normal_mode)
    end
end
