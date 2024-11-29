# nvim-claude

Un plugin de Neovim para integrar el asistente Claude de Anthropic en tu editor.

## Características

- 🤖 Integración directa con la API de Claude
- 💬 Ventana flotante para respuestas
- ✨ Soporte para selección visual
- ⚡ Respuestas asincrónicas
- 🛠 Altamente configurable

## Instalación

### Con lazy.nvim

```lua
{
  "tuusuario/nvim-claude",
  config = function()
    require("claude").setup({
      api_key = "tu-api-key-de-anthropic",
      -- Configuración opcional:
      model = "claude-3-sonnet-20240229",
      max_tokens = 1000,
      float = {
        width = 0.8,    -- 80% del ancho de la ventana
        height = 0.6,   -- 60% del alto de la ventana
        border = "rounded"
      }
    })
  end
}
```

### Con Packer

```lua
use {
  'tuusuario/nvim-claude',
  config = function()
    require('claude').setup({
      api_key = "tu-api-key-de-anthropic"
    })
  end
}
```

## Uso

El plugin proporciona dos comandos principales:

- `:Claude <prompt>` - Hacer una pregunta a Claude
- `:'<,'>ClaudeSelection` - Enviar la selección visual actual a Claude

## Configuración

```lua
require("claude").setup({
  -- Requerido
  api_key = "tu-api-key-de-anthropic",

  -- Opcional
  model = "claude-3-sonnet-20240229",  -- Modelo a usar
  max_tokens = 1000,                    -- Máximo de tokens en la respuesta
  float = {
    width = 0.8,                        -- Ancho de la ventana flotante
    height = 0.6,                       -- Alto de la ventana flotante
    border = "rounded"                  -- Estilo del borde
  }
})
```

## Licencia

MIT

## Contribuir

Las contribuciones son bienvenidas! Por favor, revisa las guías de contribución antes de enviar un PR.
