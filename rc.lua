pcall(require, 'luarocks.loader')
-- require("utils")
gears = require('gears')
beautiful = require('beautiful')
beautiful.init(gears.filesystem.get_configuration_dir() .. 'themes/default/theme.lua')
package.path = package.path .. ';' .. gears.filesystem.get_configuration_dir()

local naughty = require('naughty')
function notify(msg)
    naughty.notify(
        {
            border_width = 0,
            position = 'top_right',
            title = 'New message!',
            text = msg
        }
    )
end

local desktop = require('desktop')

desktop:init()

local awful = require('awful')

function run_once(cmd)
    local findme = "ps x U $USER |grep '" .. cmd .. "' |wc -l"
    awful.spawn.easy_async_with_shell(
        findme,
        function(stdout, stderr, reason, exit_code)
            if tonumber(stdout) <= 2 then
                -- awful.spawn(cmd)
                awful.spawn.easy_async_with_shell(cmd, nil)
            end
        end
    )
end

local cmds = {}

for _, cmd in pairs(cmds) do
    run_once(cmd)
end

require('lyrics')