function Laser (x, y , angle)
    local LAZER_SPEED = 500

    return {
        x = x,
        y = y,

        draw = function (self, faded)
            local opacity = 1

            if faded then
                opacity = 0.2
            end

            love.graphics.setColor(1,0,0,opacity)
            love.graphics.setPointSize(3)
            love.graphics.points(self.x, self.y)
        end
    }
end