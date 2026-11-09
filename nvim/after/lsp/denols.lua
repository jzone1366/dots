-- Only start in projects with a deno.json, so it doesn't compete with ts_ls.
return {
  workspace_required = true,
  root_markers = { 'deno.json' },
}
