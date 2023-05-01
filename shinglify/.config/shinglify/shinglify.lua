local function string_trim(s)
  return s:match "^%s*(.*)":match "(.-)%s*$"
end

local function map(key, command)
  key_bind(string_trim(key), function() os.execute(string_trim(command) .. " &") end)
end


local function ternary(cond, T, F)
  if cond then return T else return F end
end

function changeLayout()
  local current_layout = get_tiler(get_active_screenid())
  local layouts = {
    -- Set current screen to grid tiling
    tiler_grid,
    -- Set current screen to master/stack tiling
    tiler_masterstack,
    -- Set current screen to tabbed tiling
    tiler_vtabbed,
    -- Disable tiling on the current screen
    nil
  }

  for i, tiler in pairs(layouts) do
    if table.concat(current_layout) == table.concat(tiler) then
      local index = ternary(i == 3, 0, i + 1)
      local layout = layouts[index]

      set_tiler(get_active_screenid(), layout, true)
      break
    end
  end
end

--key_bind("Mod4-space", changeLayout())

-- Set the gaps globally. Inner, outer, single
-- Inner is the gap between windows when tiled
-- Outer is the gap between windows and the border of the usable screen space (considering panels)
-- Single is the gap around a single window on a tiled screen
set_gaps("", 5, 5, 5)

-- Set a key combo to toggle maximized/normal window size
key_bind("Mod4-z", function() maximize_window(get_active_windowid(), 2) end)

-- set launch menu
map("Mod4-return", "xfce4-appfinder")

-- Set key combos for tags. Tags can be any text and there can be any number.
map("Mod4-1", "xdotool set_desktop 0")
map("Mod4-2", "xdotool set_desktop 1")
map("Mod4-3", "xdotool set_desktop 2")
map("Mod4-4", "xdotool set_desktop 3")
map("Mod4-5", "xdotool set_desktop 4")
map("Mod4-q", "xdotool windowkill `xdotool getactivewindow`")
map("Mod4-shift-left", "bash /home/giancarlo/.scripts/swind.sh left")
map("Mod4-shift-right", "bash /home/giancarlo/.scripts/swind.sh right")
map("Mod4-shift-down", "bash /home/giancarlo/.scripts/swind.sh bottom")
map("Mod4-shift-up", "bash /home/giancarlo/.scripts/swind.sh top")
map("Mod4-shift-1", "xdotool getactivewindow set_desktop_for_window 0")
map("Mod4-shift-2", "xdotool getactivewindow set_desktop_for_window 1")
map("Mod4-shift-3", "xdotool getactivewindow set_desktop_for_window 2")
map("Mod4-shift-4", "xdotool getactivewindow set_desktop_for_window 3")
map("Mod4-shift-5", "xdotool getactivewindow set_desktop_for_window 4")


--map("Mod4-control-left", "xdotool set_desktop 3")
--map("Mod4-control-right", "xdotool set_desktop 3")

-- Lock Screen / close session
map("control-alt-end", "/usr/bin/xflock4")
map("control-alt-delete", "/usr/bin/system-monitoring-center")
map("Mod4-b", "bash ~/.scripts/search-files.sh")


---Search emoji
map("control-shift-e", "rofi -modi 'run,drun,emoji:~/.oh-my-zsh/custom/scripts/rofiemoji.sh' -show emoji -theme Arc-Dark")

---Open Google-Chrome
map("Mod4-g", "    ~/.local/bin/toggle-app.sh 'google-chrome' '/usr/bin/google-chrome'")

---Open Gnote
map("Mod4-n", "    ~/.local/bin/toggle-app.sh gnote 'flatpak run org.gnome.Gnote'")

---Terminal emulator
map("Mod4-a", "    ~/.local/bin/toggle-app.sh  Alacritty 'alacritty -e tmux'")

---Gestor de archivos
map("Mod4-b", "    bash ~/.config/bspwm/scripts/search-files.sh")

---Only-Office
map("Mod4-o", "    ~/.local/bin/toggle-app.sh DesktopEditors 'flatpak run org.onlyoffice.desktopeditors'")

---Obsidian
map("Mod4-m", "    ~/.local/bin/toggle-app.sh obsidian 'flatpak run md.obsidian.Obsidian'")

---Open Telegram
map("Mod4-t", "    ~/.local/bin/toggle-app.sh 'telegram' 'flatpak run org.telegram.desktop'")

---Navigate between open apps
map("Mod4-space",
  "    rofi -matching fuzzy -theme Arc-Dark -modi 'window,drun,tabs:~/.config/bspwm/scripts/rofi-chrome.sh,search:~/.oh-my-zsh/custom/scripts/search.py' -show search -sidebar-mode -kb-mode-next Right -kb-mode-previous Left   -kb-move-char-back  Control+Shift+Left   -kb-move-char-forward  Control+Shift+Right")

---Screen_shot
map("Print", "    flatpak run org.flameshot.Flameshot  gui")

---More volumen
map("Mod4-KP_Subtract", "  amixer -D pulse sset Master 5%-")

---Less volumen
map("Mod4-KP_Add", "  amixer -D pulse sset Master 5%+")

---Program launcher
--map("Mod4-Return",
--  "    rofi -no-config -no-lazy-grab -show drun -modi drun -theme ~/.config/polybar/shapes/scripts/rofi/launcher.rasi")


---Open Brave browser in incognito
map("control-shift-n", "    flatpak run com.brave.Browser https://duckduckgo.com -incognito")

---Cmus stop
map("Mod4-Home", "    bash ~/.config/bspwm/scripts/cmus.sh -s")

---Cmus next song
map("Mod4-Prior", "    bash ~/.config/bspwm/scripts/cmus.sh -n")

---Cmux previus song
map("Mod4-Next", "    bash ~/.config/bspwm/scripts/cmus.sh -p")

---Show help
map("Mod4-{apostrophe, KP_Divide}", "    bash ~/.config/bspwm/scripts/sxhkd_help.sh")

---Elige entre varios comandos a realizar
map("Scroll_Lock",
  "    rofi -matching fuzzy -theme Arc-Dark -modi 'search:~/.local/bin/multi.py ' -show search -sidebar-mode")

---Repite el ultimo comando seleccionado
map("Pause", "    ~/.local/bin/multi.py 'restore'")


---Emulate key search
map("Caps_Lock",
  "    rofi -matching fuzzy -theme Arc-Dark -modi 'window,drun,tabs:~/.config/bspwm/scripts/rofi-chrome.sh,search:~/.oh-my-zsh/custom/scripts/search.py' -show search -sidebar-mode -kb-mode-next Right -kb-mode-previous Left   -kb-move-char-back  Control+Shift+Left   -kb-move-char-forward  Control+Shift+Right")
