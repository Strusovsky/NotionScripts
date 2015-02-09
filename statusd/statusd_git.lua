--[[ statusd_git.lua - git status indicator for Notion WM

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

This is a git status script for the statusbar. It provides basic
functionality of displaying the current git branch, as well as the number
of changed files.

	settings = {
	  work_dir = "~/foo/bar/baz"
	  update_interval = 10 * 1000
	  blink_on_changed_files = false
	}

Uses this command to parse the current branch.

	git rev-parse --abbrev-ref HEAD
	
]]

local defaults = {
	work_dir = "$HOME",
	update_interval = 10 * 1000,	
	blink_on_changed_files = false
}

local settings = table.join(statusd.get_config("git"), defaults)

local function getgitrepo()
	local path
	if settings.work_dir then
		path = settings.work_dir
	return path .. "/"

end

local git_path = getgitrepo()

local function get_git_branch()
	local p = assert(io.open("git --git-dir=" .. git_path ".git " .. 
	"--work-tree=" .. git_path .. " rev-parse --abbrev-ref HEAD"))
	
	return p 
end

local function update_git()
	-- Get the necessary data.
	local branch = get_git_branch()

	-- Inform statusd of the available variables.
	-- 'git_branch' displays the current working branch
	statusd.inform("git_branch", branch)
	git_timer:set(settings.update_interval, update_git)
end

git_timer=statusd.create_timer()
update_git()
