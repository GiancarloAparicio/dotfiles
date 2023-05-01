local function map(key, command)
    key_bind(key, function() os.execute(command .. " &") end)
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
map("Mod4-a", "alacritty -e tmux")
map("Mod4-n", "flatpak run org.gnome.Gnote")
map("Mod4-m", "flatpak run md.obsidian.Obsidian")
map("Mod4-t", "flatpak run org.telegram.desktop")
map("Print", "flatpak run org.flameshot.Flameshot gui")
map("Mod4-g", "google-chrome-stable")
map("control-shift-n", "flatpak run com.brave.Browser https://duckduckgo.com -incognito")

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
map("Mod4-p", "/usr/bin/xflock4")
map("Mod4-b", "bash ~/.scripts/search-files.sh")
