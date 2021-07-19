return {
  command = 'golint',
  rootPatterns = {'go.mod'},
  isStdout = true,
  isStderr = false,
  debounce = 100,
  args = {'%filepath'},
  offsetLine = 0,
  offsetColumn = 0,
  formatLines = 1,
  formatPattern = {
    '^[^:]+:(\\d+):(\\d+):\\s(.*)$',
    {line = 1, column = 2, message = 3}
  },
