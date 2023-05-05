require ("components/collision")
function Button (text, x, y, width, height, func, func_param)
  return {
    text = text or "Button",
    x = x or 0,
    y = y or 0,
    width = width or 100,
    height = height or 80,
    func = func or print("This button has no function attached") end,
    func_param = func_param,
    
    draw = function (self, colorR, colorG, colorB)
      love.graphics.setColor(colorR, colorG, colorB, 1)
      love.graphics.rectangle("fill",self.x, self.y, self.width, self.height)
      love.graphics.setColor(1,1,1,1)
    end,

    buttonFunc = function (self)
      if func_param then 
        func(func_param)
      else
        func()
      end
    end,

    pressed = function (self)
      if Collision("rectangle",
      mouse_x,
      mouse_y,
      1,1,
      self.x,
      self.y,
      self.width,
      self.height) then
        self:buttonFunc()
    end
  }
  end

  return Button