local options = {
	clipboard = "unnamedplus" -- Allows nvim to use system clipboard
	completeopt = {"menuone", "noselect"}
	mouse = "a" -- Allow mouse to be used
	number = true -- Number lines
	relativenumber = false -- Relative number lines
	splitbelow = true -- Put new window before current one
	splitright = true -- ^^
	title = true -- Set title of window
	wildmenu = true

	-- Indention/Tabs
	expandtab = true
	shiftwidth = 4
	tabstop = 4

	conceallevel = 0                        -- so that `` is visible in markdown files
	fileencoding = "utf-8"                  -- the encoding written to a file
	hlsearch = true                         -- highlight all matches on previous search pattern
	ignorecase = true                       -- ignore case in search patterns
	mouse = "a"                             -- allow the mouse to be used in neovim
	pumheight = 10                          -- pop up menu height
	showmode = false                        -- we don't need to see things like -- INSERT -- anymore
	showtabline = 0                         -- always show tabs
	smartcase = true                        -- smart case
	smartindent = true                      -- make indenting smarter again
	splitbelow = true                       -- force all horizontal splits to go below current window
	splitright = true                       -- force all vertical splits to go to the right of current window
	termguicolors = true                    -- set term gui colors (most terminals support this)
	timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true                         -- enable persistent undo
	updatetime = 300                        -- faster completion (4000ms default)
	writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true                        -- convert tabs to spaces
	cursorline = true                       -- highlight the current line
	number = true                           -- set numbered lines
	guifont = "monospace:h17"               -- the font used in graphical neovim applications
}
