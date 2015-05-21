--[[ statusd_brightness.lua - brightness indicator for Notion WM

Copyright (c) 2015 Andrew Vy <andrew@andrewvy.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

Example usage:

	settings = {
		type = "percentage"
	}

]]

local defaults = {
	type = "percentage"
	update_interval = 10 * 1000,
}

local settings = table.join(statusd.get_config("brightness"), defaults)

local function get_brightness()
	local p = io.popen("tail /sys/class/backlight/acpi_video0/brightness")

	local line = p:read()
	p:close()

	return line
end

local brightness_timer

local function update_brightness()
	-- Get the necessary data.
	local brightness = get_brightness()

	-- Inform statusd of the available variables.
	-- 'git_branch' displays the current working branch
	statusd.inform("brightness", tostring(brightness))
	brightness_timer:set(settings.update_interval, update_brightness)
end

brightness_timer=statusd.create_timer()
update_brightness()
