local theme_icons = require('zone.theme.icons')
local M = {
  clients = { running = {}, exited = {} },
}

local lsp_status = require('lsp-status')
local messages = require('lsp-status/messaging').messages

local icons = {
  separator = ' ',
  spinner_frames = {
    '▆█▆',
    '▄██',
    '▂▆█',
    '▂▄▆',
    '▆▂▂',
    '█▄▂',
    '█▆▄',
  },
  status = ' ' .. theme_icons.circle .. ' ',
  code_actions = '  ',
}

local aliases = {
  pyls_ms = 'MPLS',
  lua_language_server = 'LuaLS',
}

local function getClientData(client)
  return {
    client = client,
    buffers = vim.lsp.get_buffers_by_client_id(client.id),
  }
end

local function isBufClient(clientData, bufnr)
  return vim.tbl_contains(clientData.buffers, bufnr)
end

local function getBufClients(bufnr, clients)
  local attached = {}
  for _, clientData in pairs(clients) do
    if isBufClient(clientData, bufnr) then
      table.insert(attached, clientData)
    end
  end
  return attached
end

function M.getBufClients(bufnr)
  return getBufClients(bufnr, vim.list_extend(vim.list_extend({}, M.clients.running), M.clients.exited))
end

function M.getRunningBufClients(bufnr)
  return getBufClients(bufnr, M.clients.running)
end

function M.getExitedBufClients(bufnr)
  return getBufClients(bufnr, M.clients.exited)
end

function M.on_attach(client, _) -- (client, bufnr)
  local clientData = getClientData(client)
  M.clients.running[client.id] = clientData
  M.clients.exited[client.id] = nil
  for id, exitedClientData in pairs(M.clients.exited) do
    if client.name == exitedClientData.client.name then
      M.clients.exited[id] = nil
    end
  end
  lsp_status.on_attach(client)
end

function M.on_exit(code, signal, id)
  local data = M.clients.running[id]
  data.code = code
  data.signal = signal
  M.clients.exited[id] = data
  M.clients.running[id] = nil
end

-- Adapted from
-- https://github.com/nvim-lua/lsp-status.nvim/blob/master/lua/lsp-status/statusline.lua
function M.status_progress()
  local msgs = {}
  for _, msg in ipairs(messages()) do
    local contents = msg.content
    if msg.progress then
      contents = msg.title
      if msg.message then
        contents = string.format('%s %s', contents, msg.message)
      end
      if msg.percentage then
        contents = string.format('%s (%.0f%%%%)', contents, msg.percentage)
      end
      if msg.spinner then
        local frame = icons.spinner_frames[(msg.spinner % #icons.spinner_frames) + 1]
        contents = string.format('%s %s', frame, contents)
      end
    end
    table.insert(msgs, string.format('%s %s', aliases[msg.name] or msg.name, contents))
  end
  return table.concat(msgs, icons.separator)
end

function M.status_clients(status)
  return function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = {}
    if status == 'exited' or status == 'exited_ok' or status == 'exited_err' then
      clients = M.getExitedBufClients(bufnr)
    elseif status == 'running' then
      clients = M.getRunningBufClients(bufnr)
    else
      clients = M.getBufClients(bufnr)
    end
    local count = 0
    for _, c in pairs(clients) do
      local skip = false
      skip = skip or status == 'exited_ok' and c.signal ~= 0
      skip = skip or status == 'exited_err' and c.signal == 0
      skip = skip or status == 'starting' and c.client.initialized
      skip = skip or status == 'running' and not c.client.initialized
      count = skip and count or count + 1
    end
    if count > 0 and tostring(count) then
      return tostring(count) .. icons.status
    end
  end
end

function M.code_actions()
  local bufnr = vim.api.nvim_get_current_buf()
  local code_actions = require('zone.utils.lsp').code_actions[bufnr]
  local buf_has_actions = code_actions and code_actions.count and code_actions.count > 0

  if buf_has_actions and tostring(code_actions.count) then
    return tostring(code_actions.count) .. icons.code_actions
  end
end

return M
