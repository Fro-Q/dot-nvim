return {
  "nvim-mini/mini.sessions",
  version = false,
  lazy = false,
  opts = {
    autoread = false,
    autowrite = true,
  },
  config = function (_, opts)

    local MiniSessions = require("mini.sessions")

    local map = require("utils").map

    MiniSessions.setup({opts})

    map("n", "<leader>sw", function()
      MiniSessions.write("Session.vim")
    end, "Write session")

    map("n", "<leader>sl", function()
      MiniSessions.read()
    end, "Load last session")
  end
}
