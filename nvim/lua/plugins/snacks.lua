return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        actions = {
          open_in_os = function(picker, item)
            if item and item.file then
              -- Get the path of the highlighted item
              local path = item.file

              -- Check if the item is a file or a directory
              local stat = vim.uv.fs_stat(path)

              -- If it is a file (not a directory), get its parent folder
              if stat and stat.type ~= "directory" then
                path = vim.fn.fnamemodify(path, ":h")
              end

              -- Open the directory in your OS file manager
              vim.ui.open(path)
            end
          end,
        },
        sources = {
          explorer = {
            win = {
              list = {
                keys = {
                  ["x"] = { "open_in_os", desc = "Reveal in OS File Manager" },
                },
              },
            },
          },
        },
      },
    },
  },
}
