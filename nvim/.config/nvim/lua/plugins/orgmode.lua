require('orgmode').setup({
  org_agenda_file = {'~/Dokumente/Org/*'},
  org_default_notes_file = '~/Dokumente/Org/inbox.org',
})

require'which-key'.register({
  ['<leader>'] = {
    o = {
      name = '+open',
      a = {'Org agenda'},
      c = {'Org capture'},
    }
  }
})
