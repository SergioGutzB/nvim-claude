local M = {}
local config = require("claude.config")

function M.request(prompt)
	if vim.fn.executable("curl") ~= 1 then
		error("Claude: curl es requerido para hacer peticiones a la API")
		return
	end

	local url = "https://api.anthropic.com/v1/messages"
	local headers = {
		"x-api-key: " .. config.options.api_key,
		"anthropic-version: 2023-06-01",
		"content-type: application/json",
	}

	local body = vim.fn.json_encode({
		model = config.options.model,
		max_tokens = config.options.max_tokens,
		messages = {
			{
				role = "user",
				content = prompt,
			},
		},
	})

	local response = vim.fn.system({
		"curl",
		"-s",
		url,
		"-H",
		headers[1],
		"-H",
		headers[2],
		"-H",
		headers[3],
		"-d",
		body,
	})

	local success, decoded = pcall(vim.fn.json_decode, response)
	if not success then
		error("Claude: Error al decodificar la respuesta")
		return
	end

	return decoded.content[1].text
end

return M
