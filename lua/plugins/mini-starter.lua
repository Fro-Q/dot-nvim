return {
  "nvim-mini/mini.starter",
  version = false,
  lazy = false,
  config = function()

    local MiniStarter = require("mini.starter")

    MiniStarter.setup({
      items = {
        MiniStarter.sections.builtin_actions(),
        MiniStarter.sections.recent_files(5, true, true)
      },
      footer = "Take a rest.",
      content_hooks = {
        MiniStarter.gen_hook.adding_bullet(),
        MiniStarter.gen_hook.aligning("center", "center")
      }
    })
  end
}
