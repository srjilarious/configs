-- Keymappings for moving lines up/down
vim.api.nvim_set_keymap('i', '<M-k>', '<Esc>:m .-2<CR>gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<M-j>', '<Esc>:m .+1<CR>gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-k>', '<Esc>:m .-2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-j>', '<Esc>:m .+1<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('v', '<M-k>', "<Esc>:lua MoveBlockUp()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<M-j>', "<Esc>:lua MoveBlockDown()<CR>", { noremap = true, silent = true })

local function move_block_up()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    if start_line == 1 then return end
    vim.cmd("silent! normal! " .. (start_line-1) .. "Gdd")
    vim.cmd("silent! normal! " .. (end_line-1) .. "Gp")
    vim.cmd("silent! normal! " .. (start_line-1) .. "GV" .. (end_line-1) .. "G")
end

local function move_block_down()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    if end_line == vim.fn.line("$") then return end
    vim.cmd("silent! normal! " .. (end_line+1) .. "Gdd")
    vim.cmd("silent! normal! " .. start_line-1 .. "Gp")
    vim.cmd("silent! normal! " .. (start_line+1) .. "GV" .. (end_line+1) .. "G")
end

_G.MoveBlockUp = move_block_up
_G.MoveBlockDown = move_block_down

-- Duplicate lines keymappings
vim.api.nvim_set_keymap('i', '<M-S-k>', '<Esc>:t .-1<CR>gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<M-S-j>', '<Esc>:t .<CR>gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-S-k>', '<Esc>:t .-1<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-S-j>', '<Esc>:t .<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('v', '<M-S-k>', "<Esc>:lua CopyBlockUp()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<M-S-j>', "<Esc>:lua CopyBlockDown()<CR>", { noremap = true, silent = true })

local function copy_block_up()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local lines_to_duplicate = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    vim.api.nvim_buf_set_lines(0, end_line, end_line, false, lines_to_duplicate)
    local new_end_line = end_line + (end_line-start_line) + 1
    vim.cmd("silent! normal! " .. end_line+1 .. "GV" .. new_end_line .. "G")
end

local function copy_block_down()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    local lines_to_duplicate = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    vim.api.nvim_buf_set_lines(0, end_line, end_line, false, lines_to_duplicate)
    vim.cmd("silent! normal! " .. start_line .. "GV" .. end_line .. "G")

end

_G.CopyBlockUp = copy_block_up
_G.CopyBlockDown = copy_block_down


-- Telescope find files
vim.api.nvim_set_keymap('n', '<C-p>', "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-p>', "<Esc><cmd>Telescope find_files<cr><gi>", { noremap = true, silent = true })

-- Telescope find buffer mappings
vim.api.nvim_set_keymap('n', '<C-b>', "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-b>', "<Esc><cmd>Telescope buffers<cr><gi>", { noremap = true, silent = true })


-- Switch to the buffers using Ctrl+(Shift+)Tab
vim.api.nvim_set_keymap('n', '<C-Tab>', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-Tab>', '<Esc>:bnext<CR>gi', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-S-Tab>', ':bprevious<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-S-Tab>', '<Esc>:bprevious<CR>gi', {noremap = true, silent = true})

-- Shift Tab should unindent in insert/normal mode.
vim.api.nvim_set_keymap('n', '<S-Tab>', '<<', {silent = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', '<C-d>', {silent = true})

vim.api.nvim_set_keymap('n', '<C-_>', ':VimwikiIncrementListItem<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-Bslash>', ':VimwikiDecrementListItem<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('i', '<C-s>', '<C-o>:w<CR>', { noremap = true, silent = true })

-- Start visual selection on ctrl+shift+left/right
vim.api.nvim_set_keymap('i', '<C-S-Left>', 'vge', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-S-Right>', 'v<Space>w', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-S-Left>', 'vge', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-S-Right>', 'v<Space>w', {noremap = true})

-- Enter the current directory when vim starts
-- % curr file, :p full path, :h get dir
local file_path = vim.fn.expand("%p")
local is_dir = vim.fn.isdirectory(file_path)
if is_dir == 1 then
  vim.api.nvim_create_autocmd("VimEnter", {pattern = "*", command = "silent! cd %:p"})
  vim.api.nvim_create_autocmd("VimEnter", {pattern = "*", command = "TermExec open=0 cmd='cd %:p && clear'"})
else
  vim.api.nvim_create_autocmd("VimEnter", {pattern = "*", command = "silent! cd %:p:h"})
  vim.api.nvim_create_autocmd("VimEnter", {pattern = "*", command = "TermExec open=0 cmd='cd %:p:h && clear'"})
end

vim.opt.list = true
vim.opt.listchars:append({space = "·", lead = "·", tab = "» ", trail = "·"}) --, trail = '·', setbreak = "···", space = '·' }
vim.opt.showbreak = "↪  "
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

return {
  plugins = {
    "AstroNvim/astrocommunity",
    {
      'vimwiki/vimwiki',
      event = "BufEnter *.md",
      keys = {"<leader>ww", "<leader>wt"},
      enabled = true,
      init = function () --replace 'config' with 'init'
        vim.g.vimwiki_list = {{path = '~/code/tech-notes/wiki', syntax = 'markdown', ext = '.md'}}
        vim.g.vimwiki_listsyms = " ◔◑◕✓"
        -- vim.api.nvim_set_keymap('n', '<C-]>', '<Plug>VimwikiNextLink', {silent=true})
        -- vim.api.nvim_set_keymap('n', '<C-[>', '<Plug>VimwikiPrevLink', {silent=true})
        vim.api.nvim_set_keymap('n', '<S-Tab>', '<Plug>VimwikiDecreaseLvlWholeItem', {silent=true})
        vim.api.nvim_set_keymap('n', '<Tab>', '<Plug>VimwikiIncreaseLvlWholeItem', {silent=true})
      end,
    },
    {
      "goolord/alpha-nvim",
      opts = function(_, opts) -- override the options using lazy.nvim
        opts.section.header.val = { -- change the header section value
        " █     █░███▄    █   ██████ ",
        "▓█░ █ ░█░██ ▀█   █ ▒██    ▒ ",
        "▒█░ █ ░█▓██  ▀█ ██▒░ ▓██▄   ",
        "░█░ █ ░█▓██▒  ▐▌██▒  ▒   ██▒",
        "░░██▒██▓▒██░   ▓██░▒██████▒▒",
        "░ ▓░▒ ▒ ░ ▒░   ▒ ▒ ▒ ▒▓▒ ▒ ░",
        "  ▒ ░ ░ ░ ░░   ░ ▒░░ ░▒  ░ ░",
        "  ░   ░    ░   ░ ░ ░  ░  ░  ",
        "    ░            ░       ░  ",
        "                            ",
        "        Code Hard           ",
        }
      end,
    },
    { -- Add in the mode text to the status line
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        local status = require("astronvim.utils.status")
        opts.statusline = { -- statusline
          hl = { fg = "fg", bg = "bg" },
          status.component.mode { mode_text = { padding = { left = 1, right = 1 } } }, -- add the mode text
          status.component.git_branch(),
          status.component.file_info { filetype = {}, filename = false, file_modified = false },
          status.component.git_diff(),
          status.component.diagnostics(),
          status.component.fill(),
          status.component.cmd_info(),
          status.component.fill(),
          status.component.lsp(),
          status.component.treesitter(),
          status.component.nav(),
          -- remove the 2nd mode indicator on the right
        }

        -- return the final configuration table
        return opts
      end,
    },
    {
        'lukas-reineke/headlines.nvim',
        event = "BufEnter *.md",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true, -- or `opts = {}`
        lazy=false,
    },
    { import = "astrocommunity.pack.rust" },
    { import = "astrocommunity.pack.markdown" },
    -- { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
    { import = "astrocommunity.colorscheme.kanagawa", lazy=false},
    { import = "astrocommunity.colorscheme.catppuccin", lazy = false},
    { import = "astrocommunity.colorscheme.oxocarbon", lazy=false},
    { import = "astrocommunity.colorscheme.nightfox", lazy=false},
    { import = "astrocommunity.motion.leap-nvim"},
  },
  colorscheme = "kanagawa"
}

