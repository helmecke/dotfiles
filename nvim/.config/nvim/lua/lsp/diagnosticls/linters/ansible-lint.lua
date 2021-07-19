return {
  command = 'ansible-lint',
  sourceName = 'ansible-lint',
  args = { "-f=codeclimate", "-"},
  parseJson = {
    errorsRoot = '[0]',
    line = 'location.lines.begin',
    endLine = 'location.lines.begin',
    message = 'check_name',
    security = 'severity',
  },
  securities  = {
    blocker = "error",
    critical = "warning",
  },
}
