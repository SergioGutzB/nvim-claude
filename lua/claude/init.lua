local config = require("claude.config")
local api = require("claude.api")

local M = {}

-- Función para crear la ventana flotante
local function create_float()
	local width = math.floor(vim.api.nvim_get_option("columns") * config.options.float.width)
	local height = math.floor(vim.api.nvim_get_option("lines") * config.options.float.height)

	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = (vim.o.columns - width) / 2,
		row = (vim.o.lines - height) / 2,
		border = config.options.float.border,
		style = "minimal",
	})

	return buf, win
end

-- Función para manejar la respuesta
function M.handle_response(prompt)
	local response = api.request(prompt)
	if not response then
		return
	end

	local buf, _ = create_float()
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(response, "\n"))
end

function M.setup(opts)
	config.setup(opts)

	-- Crear comando de usuario
	vim.api.nvim_create_user_command("Claude", function(opts)
		M.handle_response(opts.args)
	end, { nargs = "+" })

	-- Crear comando para selección visual
	vim.api.nvim_create_user_command("ClaudeSelection", function()
		local start_pos = vim.fn.getpos("'<")
		local end_pos = vim.fn.getpos("'>")
		local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
		local text = table.concat(lines, "\n")
		M.handle_response(text)
	end, { range = true })
end

return M
