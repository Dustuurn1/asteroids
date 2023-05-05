function Collision 
    (type,
    obj_1_x,
    obj_1_y, 
    obj_1_width, 
    obj_1_height,
    obj_2_x,
    obj_2_y,
    obj_2_width,
    obj_2_height)

    if type == "rectangle" then
        --Left side within obj2 width
        if (obj_1_x >= obj_2_x) and 
        (obj_1_x <= obj_2_x + obj_2_width) then
            --Top within obj height
            if (obj_1_y >= obj_2_y) and
            (obj_1_y <= obj_2_y + obj_2_height) then
                return true
            --Bottom within obj height
            elseif (obj_1_y + obj_1_height >= obj_2_y) and
            (obj_1_y + obj_1_height <= obj_2_y + obj_2_height)
                return true
            end
        --Right side within obj width
        elseif (obj_1_x + obj_1_width >= obj_2_x) and
        (obj_1_x + obj_1_width <= obj_2_x + obj_2_width)
            return true
        end
    elseif type == "circle" then
        --TODO
        return false
    end


end

return Collision