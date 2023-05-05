
local Player = require "objects/player"
local Game = require "states/game"
local Menu = require "states/menu"
require("components/text")
math.randomseed(os.time())
----------------------Locals----------------------


------------------Main Functions------------------
function love.load()
    love.mouse.setVisible(false)
    mouse_x, mouse_y = 0, 0

    local show_debugging = true

    menu = Menu()
    player = Player(show_debugging)
    game = Game()

    if game.state.running then
    game:startNewGame(player)
    else menu:load()
    end
end

function love.update(dt)
    mouse_x, mouse_y = love.mouse.getPosition()
    if game.state.menu then
        menu:draw()
    end

    if game.state.running then
        player:move()
        
        for ast_index, asteroid in pairs(asteroids) do
            asteroid:move(dt)
        end
    end
    
    
end

function love.draw()
    if game.state.running or game.state.paused then
    player:draw(game.state.paused)

        for _, asteroid in pairs(asteroids) do 
            asteroid:draw(game.state.paused)
        end

    game:draw(game.state.paused)
    end
    love.graphics.setColor(1,1,1,1)
    love.graphics.print("FPS " .. love.timer.getFPS(),10,10)
end


------------------Keypress Functions------------------
function love.keypressed(key)
    if game.state.running then
        if key == "w" then
            player.thrusting = true
        end
        if key == "escape" then
            game:changeGameState("paused")  
        end
    elseif game.state.paused then
        if key == "escape" then
            game:changeGameState("running")     
        end
    end

end

function love.keyreleased(key)
    if key == "w" then
        player.thrusting = false
    end
end

