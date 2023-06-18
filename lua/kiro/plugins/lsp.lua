local function attach_handle(_, bufnr)
  local signs = { Error = ' ', Warn = ' ', Hint = '󰮦 ', Info = ' ' }

  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  local km = vim.keymap.set
  local opts = function(desc)
    return {
      silent = true,
      buffer = bufnr,
      desc = desc,
    }
  end
  local lb = vim.lsp.buf
  local diagnostic = vim.diagnostic

  local lead = function(key) return 'g' .. key end

  km('n', 'K', lb.hover, opts('LSP Hover'))
  km('n', lead('d'), lb.definition, opts('Goto Definition'))
  km('n', lead('D'), lb.declaration, opts('Goto Decleration'))
  km('n', lead('i'), lb.implementation, opts('Goto Implementation'))
  km('n', lead('o'), lb.type_definition, opts('Goto Type Definition'))
  -- km('n', lead('r'), lsp.references, opts('References'))
  km('n', lead('r'), '<cmd>Telescope lsp_references<cr>', opts('References'))
  km('n', lead('s'), lb.signature_help, opts('Signature Help'))
  km('n', '<F2>', lb.rename, opts('Rename Sybmol'))
  km(
    { 'n', 'x' },
    '<F3>',
    function() lb.format({ async = true }) end,
    opts('Format')
  )
  km({ 'n', 'x' }, '<F4>', lb.code_action, opts('Code Action'))
  km('n', 'gl', diagnostic.open_float, opts('Diagnostic Float'))
  km('n', '[d', diagnostic.goto_prev, opts('Goto Prev Diagnostic'))
  km('n', ']d', diagnostic.goto_next, opts('Goto Next Diagnostic'))
end

return {
  {
    'VonHeikemen/lsp-zero.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    branch = 'v2.x',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'jose-elias-alvarez/null-ls.nvim' },
    },
    config = function()
      local lsp = require('lsp-zero.init').preset({})

      -- Fix Undefined global 'vim'
      lsp.nvim_workspace()

      lsp.ensure_installed({
        'tsserver',
        'eslint',
        'rust_analyzer',
        'lua_ls',
        'clangd',
      })

      lsp.set_preferences({
        suggest_lsp_servers = true,
        sign_icons = {
          Error = ' ',
          Warn = ' ',
          Hint = '󰮦 ',
          Info = ' ',
        },
      })

      lsp.format_on_save({
        format_opts = {
          async = true,
          timeout_ms = 10000,
        },
        servers = {
          ['rust_analyzer'] = { 'rust' },
          ['clangd'] = { 'c', 'cpp', 'cs', 'cuda', 'proto' },
          ['null-ls'] = {
            -- prettier
            'angular',
            'css',
            'flow',
            'graphql',
            'html',
            'json',
            'jsx',
            'javascript',
            'less',
            'markdown',
            'scss',
            'typescript',
            'vue',
            'yaml',
            --
            'lua',
          },
        },
      })

      lsp.extend_lspconfig({
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
      })

      lsp.on_attach(attach_handle)

      lsp.setup()

      require('kiro.plugins_config.null-ls')
      require('kiro.plugins_config.lspconfig')

      vim.diagnostic.config({ virtual_text = true })
    end,
  },
}
