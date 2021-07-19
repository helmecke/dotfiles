return {
  command = 'yamllint',
  sourceName = 'yamllint',
  args = { "-f=parsable", "-"},
  formatPattern = {
    [[^([^:]+):(\d+):(\d+):\s+\[(\w+)\]+\s+(.*)$]],
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
  },
}
