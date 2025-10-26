return {
  "sphamba/smear-cursor.nvim",
  lazy = false,
  opts = {
    cursor_color = "#e0926d",
    stiffness = 0.3,
    trailing_stiffness = 0.1,
    damping = 0.5,
    trailing_exponent = 10,
    never_draw_over_target = true,
    hide_target_hack = true,
    gamma = 1,
    smear_insert_mode = true,
  }
}
