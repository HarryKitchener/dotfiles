
-- bufferline.lua configuration
require('bufferline').setup{
  options = {
    numbers = "ordinal", -- Use ordinal numbers instead of absolute numbers
    separator_style = "thin", -- Set the separator style to "thin"
    diagnostics = "nvim_lsp", -- Show diagnostic indicators from Neovim LSP client
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")" -- Customize the format of the diagnostic indicators
    end,
    always_show_bufferline = true, -- Always show the bufferline, even if there's only one buffer
    offsets = {
      {
        filetype = "NvimTree", -- Exclude NvimTree from the bufferline
        text = "File Explorer",
        highlight = "Directory",
        text_align = "center"
      }
    },
    show_buffer_icons = true, -- Show buffer icons
    show_buffer_close_icons = true, -- Show close icons for buffers
    show_close_icon = true, -- Show the close icon on the bufferline
    indicator_icon = '▎', -- Customize the indicator icon
    modified_icon = '●', -- Customize the modified buffer icon
    close_icon = '', -- Customize the close buffer icon
    max_name_length = 18, -- Truncate buffer names if they exceed the maximum length
    max_prefix_length = 15, -- Truncate buffer name prefixes if they exceed the maximum length
    tab_size = 18, -- Set the maximum width of tab names
    diagnostics_update_in_insert = false, -- Update diagnostics only on CursorHold
  }
}
