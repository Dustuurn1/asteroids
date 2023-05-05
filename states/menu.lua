function Menu ()
    buttons = {}
    return {

        load = function ()
            table.insert.startButton(buttons,Button(
                "Start",
                love.graphics.getWidth()/2 - 100,
                love.graphics.getHeight()/3 -70,
                200,
                70,
                changeGameState("running"),
                nil))

                table.insert.settingsButton(buttons,Button(
                "Settings",
                love.graphics.getWidth()/2 - 100,
                love.graphics.getHeight()/3 + 10,
                200,
                70,
                changeGameState("settings"),
                nil))

                table.insert.quitButton(buttons,Button(
                "Exit To Desktop",
                love.graphics.getWidth()/2 - 100,
                love.graphics.getHeight()/3 -70,
                200,
                70,
                --Love quit function,
                nil))
            
        end,

        draw = function()
            --loop through buttons table
            for i = 1, buttons in pairs(buttons) do
                button:draw(196/255, 100/255,100/255)
        end
    }
end

return Menu