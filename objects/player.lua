local Laser =  require "objects.laser"
function Player(debugging)
    local SHIP_SIZE = 30
    local VIEW_ANGLE = math.rad(90)

    debugging = debugging or false

    return {
        x = love.graphics.getWidth() / 2,
        y = love.graphics.getHeight() / 2,
        radius = SHIP_SIZE / 2,
        angle = VIEW_ANGLE,
        rotation = 0,
        thrusting = false,
        lasers = {},
        thrust = {
            x = 0,
            y = 0,
            speed = 5,
            big_flame = false,
            flame = 2.0
        },

        draw = function (self, faded)
            local opacity = 1

            if faded then 
                opacity = 0.2
            end
            
            if debugging then
                love.graphics.setColor(1,0,0)

                love.graphics.rectangle("fill",self.x - 1, self.y - 1, 2, 2)

                love.graphics.circle("line", self.x, self.y, self.radius)
            end

            if self.thrusting then
                if not self.thrust.big_flame then
                    self.thrust.flame = self.thrust.flame - 1 / love.timer.getFPS()

                    if self.thrust.flame < 1.5 then
                        self.thrust.big_flame = true
                    end
                else
                    self.thrust.flame = self.thrust.flame + 1 / love.timer.getFPS()

                    if self.thrust.flame > 2.5 then
                        self.thrust.big_flame = false
                    end
                end

                self:drawFlame("fill",{255/255,102/255,25/255})
                self:drawFlame("line",{255/255,41/255,0})
            end

            love.graphics.setColor(1,1,1,opacity)

            love.graphics.polygon(
                "line",
                self.x + (4/3 * self.radius) * math.cos(self.angle),
                self.y - (4/3 * self.radius) * math.sin(self.angle),
                self.x - self.radius * (2/3 * math.cos(self.angle) + math.sin(self.angle)),
                self.y + self.radius * (2/3 * math.sin(self.angle) - math.cos(self.angle)),
                self.x - self.radius * (2/3 * math.cos(self.angle) - math.sin(self.angle)),
                self.y + self.radius * (2/3 * math.sin(self.angle) + math.cos(self.angle))
            )
        end,

        move = function (self)
            local FPS = love.timer.getFPS()
            local friction = 0.7

            self.rotation = 2 * math.pi / FPS

            if love.keyboard.isDown("a") then
                self.angle = self.angle + self.rotation
            elseif love.keyboard.isDown("d") then
                self.angle = self.angle - self.rotation
            end

            if self.thrusting then 
                self.thrust.x = self.thrust.x + self.thrust.speed * math.cos(self.angle) / FPS
                self.thrust.y = self.thrust.y - self.thrust.speed * math.sin(self.angle) / FPS
            elseif self.thrust.x ~= 0 or self.thrust.y ~=0 then
                self.thrust.x = self.thrust.x - friction * self.thrust.x / FPS
                self.thrust.y = self.thrust.y - friction * self.thrust.y / FPS
            end

            self.x = self.x + self.thrust.x 
            self.y = self.y + self.thrust.y 

            if self.x + self.radius < 0 then
                self.x = love.graphics.getWidth() + self.radius
            elseif self.x - self.radius > love.graphics.getWidth() then
                self.x = -self.radius
            end
            if self.y - self.radius > love.graphics.getHeight() then
                self.y = -self.radius
            elseif self.y + self.radius < 0 then
                self.y = love.graphics.getHeight() + self.radius
            end
        end,

        drawFlame = function (self,fill_type,color)
            love.graphics.setColor(color)

            love.graphics.polygon(
                fill_type,
                self.x - self.radius * (2/3 * math.cos(self.angle) + 0.5 * math.sin(self.angle)),
                self.y + self.radius * (2/3 * math.sin(self.angle) - 0.5 * math.cos(self.angle)),
                self.x - self.radius * self.thrust.flame * math.cos(self.angle),
                self.y + self.radius * self.thrust.flame * math.sin(self.angle),
                self.x - self.radius * (2/3 * math.cos(self.angle) - 0.5 * math.sin(self.angle)),
                self.y + self.radius * (2/3 * math.sin(self.angle) + 0.5 * math.cos(self.angle))
            )
        end,

        shootLaser = function(self)
            table.insert(self.lasers, Laser(self.x, self.y, self.angle))
            
        end
    }
end

return Player