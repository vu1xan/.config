return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'helix',
    -- preset = 'modern',
    delay = 0,
    height = math.huge,
    icons = {
      mappings = true, -- disable icons in keymaps
    },
    sort = { 'alphanum' },
    spec = {
      -- { '<leader>b', group = 'Buffers' },
      -- { '<leader>d', group = 'Diagnostic' },
      { '<leader>f', group = '+[f]ind' },
      { '<leader>fD', '<cmd>Telescope diagnostics bufnr=0<CR>', desc = 'buffer [D]iagnostics' },
      { '<leader>fM', '<cmd>Telescope man_pages<cr>', desc = '[M]an pages' },
      { '<leader>fb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = '[b]uffer fuzzy find' },
      { '<leader>fc', '<cmd>Telescope grep_string<cr>', desc = 'string under [c]ursor in cwd' },
      { '<leader>fd', '<cmd>Telescope buffers<cr>', desc = 'buffers' },
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = '[f]iles' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = '[g]rep' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = '[h]elp' },
      { '<leader>fj', '<cmd>Telescope jumplist<cr>', desc = '[j]umplist' },
      { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = '[k]eymaps' },
      { '<leader>fl', '<cmd>Telescope loclist<cr>', desc = '[l]oclist' },
      { '<leader>fm', '<cmd>Telescope marks<cr>', desc = '[m]arks' },
      { '<leader>fq', '<cmd>Telescope quickfix<cr>', desc = '[q]uickfix' },
      { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = '[r]ecents' },
      { '<leader>ft', '<cmd>TodoTelescope<cr>', desc = "[T]ODO's" },

      { '<leader>s', group = '+[s]plit window' },
      { '<leader>se', '<C-w>e', desc = 'make splits [e]qual' },
      { '<leader>sh', '<C-w>h', desc = '[h]orizontally' },
      { '<leader>so', '<cmd>only<cr>', desc = '[o]nly this remains' },
      { '<leader>sv', '<C-w>v', desc = '[v]ertically' },

      { '<leader>t', group = '+[t]abs' },
      -- { "<leader>tc", <function 1>, desc = "new tab with [c]wd" },
      { '<leader>tf', '<cmd>tabnew %<CR>', desc = 'current bu[f]fer in new tab' },
      { '<leader>tn', '<cmd>tabnew<CR>', desc = '[n]ew' },

      { '<leader>r', group = '+[r]epl' },
      { '<leader>e', group = '+iron s[e]nd' },
      { '<leader>m', group = '+iron [m]ark' },
      { '<leader>s', group = '+[s]plits' },
      { '<leader>t', group = '+[t]abs' },

      { '<leader>m', group = 'iron [m]ark' },
      { '<leader>mc', desc = 'motion' },
      { '<leader>md', desc = 'remove mark' },

      { '<leader>m', group = 'iron [m]ark', mode = 'v' },
      { '<leader>mc', desc = 'visual', mode = 'v' },

      { '<leader>s', group = 'iron [s]end' },
      { '<leader>s ', desc = 'interrupt' },
      { '<leader>s<cr>', desc = 'empty line in repl' },
      { '<leader>sb', desc = 'code [b]lock' },
      { '<leader>sc', desc = 'motion' },
      { '<leader>sf', desc = '[f]ile' },
      { '<leader>sl', desc = '[l]ine' },
      { '<leader>sm', desc = '[m]ark' },
      { '<leader>sn', desc = 'code block [n] move' },
      { '<leader>sp', desc = '[p]aragraph' },
      { '<leader>sq', desc = 'exit' },
      { '<leader>su', desc = 'until [c]ursor' },
      { '<leader>sx', desc = 'clear' },

      { '<leader>s', group = 'iron [s]end', mode = 'v' },
      { '<leader>sc', desc = 'visual', mode = 'v' },

      { '<leader>r', group = '[r]epl' },
      { '<leader>rR', desc = '[R]estart' },
      { '<leader>rf', '<cmd>IronFocus<cr>', desc = '[f]ocus' },
      { '<leader>rh', '<cmd>IronHide<cr>', desc = '[h]ide' },
      { '<leader>rr', desc = 'toggle' },
      { '<leader>rv', desc = '[v]ertical' },
      { '<leader>rz', desc = 'hori[z]ontal' },

      -- { 'zC', hidden = true },
      -- { 'zx', hidden = true },
    },
  },
  config = function(_, opts)
    require('which-key').setup(opts)
  end,
}
