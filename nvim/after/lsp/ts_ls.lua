-- Only start in projects with a package.json, so it doesn't compete with denols.
return {
  workspace_required = true,
  root_markers = { 'package.json' },
}
