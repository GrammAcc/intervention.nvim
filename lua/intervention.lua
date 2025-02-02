local M = {}
M._recall_buffer = nil
M._term_buffer = nil

function M.recall()
  if M._recall_buffer == nil then
    return
  else
    vim.api.nvim_set_current_buf(M._recall_buffer)
  end
end

function M.mark()
  M._recall_buffer = vim.api.nvim_get_current_buf()
end

function M.toggle_term()
  if M._term_buffer and vim.api.nvim_buf_is_valid(M._term_buffer) then
    if vim.api.nvim_get_current_buf() == M._term_buffer then
      M.recall()
    else
      M.mark()
      vim.api.nvim_set_current_buf(M._term_buffer)
      vim.cmd("startinsert")
    end
  else
    M.mark()
    vim.cmd("term")
    vim.cmd("startinsert")
    M._term_buffer = vim.api.nvim_get_current_buf()
  end
end

function M.setup(opts)
  -- NOOP for compat with Lazy.nvim patterns.
  return
end

function M.version()
  return "0.1.0"
end

return M
