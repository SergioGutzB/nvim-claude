local M = {}

M.defaults = {
	api_key = nil,
	model = "claude-3-sonnet-20240229",
	max_tokens = 1000,
	float = {
		width = 0.8, -- 80% del ancho de la ventana
		height = 0.6, -- 60% del alto de la ventana
		border = "rounded",
	},
}

M.options = {}

function M.setup(opts)
	M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})

	if not M.options.api_key then
		error("Claude: Se requiere una API key de Anthropic. Configúrala en setup()")
	end
end

return M
