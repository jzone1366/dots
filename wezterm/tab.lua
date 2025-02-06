local wezterm = require("wezterm")
local catppuccin = require("palettes.catppuccin")
--local evergarden = require("palettes.evergarden")

local Tab = {}

local function get_process(tab)
	local process_icons = {
		["docker"] = {
			{ Text = "󰡨" },
		},
		["docker-compose"] = {
			{ Text = "󰡨" },
		},
		["lazydocker"] = {
			{ Text = "󰡨" },
		},
		["nvim"] = {
			{ Text = "" },
		},
		["vim"] = {
			{ Text = "" },
		},
		["node"] = {
			{ Text = "󰋘" },
		},
		["zsh"] = {
			{ Text = "" },
		},
		["bash"] = {
			{ Text = "" },
		},
		["htop"] = {
			{ Text = "" },
		},
		["btop"] = {
			{ Text = "" },
		},
		["bpytop"] = {
			{ Text = "" },
		},
		["cargo"] = {
			{ Text = "󰣣" },
		},
		["go"] = {
			{ Text = "" },
		},
		["git"] = {
			{ Text = "󰊢" },
		},
		["lazygit"] = {
			{ Text = "󰊢" },
		},
		["lua"] = {
			{ Text = "" },
		},
		["wget"] = {
			{ Text = "󰄠" },
		},
		["curl"] = {
			{ Text = "" },
		},
		["gh"] = {
			{ Text = "" },
		},
		["flatpak"] = {
			{ Text = "󰏖" },
		},
		["dotnet"] = {
			{ Text = "󰪮" },
		},
		["cointop"] = {
			{ Text = "" },
		},
		["composer"] = {
			{ Text = "" },
		},
	}

	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")
	if not process_name then
		process_name = "zsh"
	end
	return wezterm.format(process_icons[process_name] or { { Text = string.format("[%s]", process_name) } })
end

local function get_current_working_folder_name(tab)
	local cwd_uri = tab.active_pane.current_working_dir

	if cwd_uri then
		local cwd = ""
		if type(cwd_uri) == "userdata" then
			cwd = cwd_uri.file_path
		else
			cwd_uri = cwd_uri:sub(8)
			local slash = cwd_uri:find("/")
			if slash then
				cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
					return string.char(tonumber(hex, 16))
				end)
			end
		end

		if cwd == os.getenv("HOME") then
			return "~"
		end

		return string.format("%s", string.match(cwd, "[^/]+$"))
	end
end

function Tab.apply_to_config(config)
	-- TAB Bar
	config.use_fancy_tab_bar = true
	config.tab_max_width = 50
	config.hide_tab_bar_if_only_one_tab = false

	wezterm.on("format-tab-title", function(tab)
		return wezterm.format({
			{ Attribute = { Intensity = "Half" } },
			{ Text = string.format(" %s  ", tab.tab_index + 1) },
			"ResetAttributes",
			{ Text = get_process(tab) },
			{ Text = " " },
			{ Text = get_current_working_folder_name(tab) },
			{ Text = "  ▕" },
		})
	end)

	wezterm.on("update-status", function(window, pane)
		local cells = {}

		-- Figure out the hostname of the pane on a best-effort basis
		local hostname = wezterm.hostname()
		local cwd_uri = pane:get_current_working_dir()
		if cwd_uri and cwd_uri.host then
			hostname = cwd_uri.host
		end
		table.insert(cells, " " .. hostname)

		-- Format date/time in this style: "Wed Mar 3 08:14"
		local date = wezterm.strftime(" %a %b %-d %H:%M")
		table.insert(cells, date)

		-- Add an entry for each battery (typically 0 or 1)
		local batt_icons = { "", "", "", "", "" }
		for _, b in ipairs(wezterm.battery_info()) do
			local curr_batt_icon = batt_icons[math.ceil(b.state_of_charge * #batt_icons)]
			table.insert(cells, string.format("%s %.0f%%", curr_batt_icon, b.state_of_charge * 100))
		end

		-- Color palette for each cell
		local text_fg = catppuccin.mocha.background
		local colors = {
			catppuccin.mocha.background,
			catppuccin.mocha.blue,
			catppuccin.mocha.cyan,
			catppuccin.mocha.green,
		}

		--local text_fg = evergarden.colors.crust
		--local colors = {
		--	evergarden.colors.mantle,
		--	evergarden.colors.blue,
		--	evergarden.colors.aqua,
		--	evergarden.colors.green,
		--}

		local elements = {}
		while #cells > 0 and #colors > 1 do
			local text = table.remove(cells, 1)
			local prev_color = table.remove(colors, 1)
			local curr_color = colors[1]

			table.insert(elements, { Background = { Color = prev_color } })
			table.insert(elements, { Foreground = { Color = curr_color } })
			table.insert(elements, { Text = "" })
			table.insert(elements, { Background = { Color = curr_color } })
			table.insert(elements, { Foreground = { Color = text_fg } })
			table.insert(elements, { Text = " " .. text .. " " })
		end
		window:set_right_status(wezterm.format(elements))

		---- Left status (left of the tab line)
		--local stat = window:active_workspace()
		--local stat_color = "#f7768e"
		---- It's a little silly to have workspace name all the time
		---- Utilize this to display LDR or current key table name
		--if window:active_key_table() then
		--  stat = window:active_key_table()
		--  stat_color = "#7dcfff"
		--end
		--if window:leader_is_active() then
		--  stat = "LDR"
		--  stat_color = "#bb9af7"
		--end
		--window:set_left_status(wezterm.format({
		--  { Foreground = { Color = stat_color } },
		--  { Text = "  " },
		--  { Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
		--  { Text = " |" },
		--}))
		--
	end)
end

return Tab
