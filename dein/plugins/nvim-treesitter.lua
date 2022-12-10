-- https://github.com/nvim-treesitter/nvim-treesitter/pull/2809
-- maintainedはdeprecatedしたので、個別に指定

require('nvim-treesitter.configs').setup {
  ensure_installed =  {
          'bash', 'blueprint', 'c', 'c_sharp', 'cmake',
          'cpp', 'css', 'd', 'dart', 'diff',
          'dockerfile', 'dot', 'elixir', 'erlang',
          'git_rebase', 'gitattributes', 'gitcommit', 'gitignore', 'gleam',
          'glsl', 'go', 'gomod', 'gowork', 'graphql',
          'help', 'hjson', 'html', 'http', 'java',
          'javascript', 'jq', 'jsdoc', 'json', 'json5',
          'jsonnet', 'kotlin', 'llvm', 'lua',
          'make', 'markdown', 'markdown_inline', 'perl', 'php',
          'phpdoc', 'prisma', 'python', 'regex', 'rst', 'ruby',
          'rust', 'scala', 'scheme', 'scss', 'sql', 'svelte',
          'swift', 'todotxt', 'toml', 'tsx', 'twig', 'typescript',
          'vim', 'vue', 'wgsl', 'yaml', 'yang'
  },
  highlight = {
    enable = true,
  },
  autotag = {
          enable = true,
          }
}

