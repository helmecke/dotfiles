return {
  sourceName = 'golangci_lint',
  command = 'golangci-lint',
  args = {'run', '--out-format', 'json', '--disable-all', '-E', 'revive'},
  debounce = 100,
  parseJson = {
    sourceNameFilter = true,
    sourceName = 'Pos.Filename',
    errorsRoot = 'Issues',
    line = 'Pos.Line',
    column = 'Pos.Column',
    message = '${Text} [${FromLinter}]'
  },
  rootPatterns = {'.git', 'go.mod'},
}
