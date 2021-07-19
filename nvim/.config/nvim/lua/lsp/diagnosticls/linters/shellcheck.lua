return {
  command = "shellcheck",
  rootPatterns = {},
  isStdout = true,
  isStderr = false,
  debounce = 100,
  args = { "--format=gcc", "-"},
  offsetLine = 0,
  offsetColumn = 0,
  sourceName = "shellcheck",
  formatLines = 1,
  formatPattern = {
    "^([^:]+):(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$",
    {
      line = 2,
      column = 3,
      endline = 2,
      endColumn = 3,
      message = {5},
      security = 4
    }
  },
  securities  = {
    error  ="error",
    warning = "warning",
    note = "info"
  },
}
