local Text = require "../components/text"
local Asteroid = require "../objects/asteroid"
function Game()
    asteroids = {}
    return {
        level = 1,
        state = {
            menu = false,
            paused = false,
            running = true,
            ended = false
        },

        changeGameState = function (self, state)
            self.state.menu     = state == "menu"
            self.state.paused   = state == "paused"
            self.state.running  = state == "running"
            self.state.ended    = state == "ended"
        end,

        draw = function (self, faded)
            if faded then
                Text(
                    "Paused",
                    0,
                    love.graphics.getHeight() * 0.4,
                    "h2",
                    false,
                    false,
                    "center"
                ):draw()
            end
        end,

        startNewGame = function (self, player)
            self:changeGameState("running")

            local as_x = math.floor(math.random(love.graphics.getWidth()))
            local as_y = math.floor(math.random(love.graphics.getHeight()))

            table.insert(asteroids, 1 , Asteroid(as_x, as_y, 100, self.level, true))
        end
    }
end

return Game