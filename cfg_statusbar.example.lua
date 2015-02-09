-- Example cfg_statusbar.lua script -

-- Create the status bar with your desired settings.
-- The template string is required, and is based off the modules that you load below.

mod_statusbar.create {
	screen=0,
	pos='bl'
	fullsize=true,
	systray=true,
	template="%date - %filler%systray"
}

-- Load the desired modules. Options can be passed into modules.
-- In this exampe, we're loading the built-in date module, and passing in a formatted string.


mod_statusbar.launch_statusd {
	date = {
		date_format='%a 5m/%d %H:%M'
	}
}
