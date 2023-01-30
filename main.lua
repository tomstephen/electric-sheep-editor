local canvas = {width = 600, height = 300}

function love.load()
    myCanvas = love.graphics.newCanvas(canvas.width, canvas.height)

    love.graphics.setCanvas(myCanvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.rectangle('fill', 0, 0, canvas.width, canvas.height)
    love.graphics.setCanvas()
end

local isHeld = false
local px = 0
local py = 0

function love.update()
    love.graphics.setCanvas(myCanvas)
        -- Do your drawing in here
        if love.mouse.isDown(1) then
            local x = love.mouse.getX() - 100
            local y = love.mouse.getY() - 100
            if isHeld then
                love.graphics.setColor(1, 0, 0, 1)
                love.graphics.line(px, py, x, y)
            else
                isHeld = true
            end
            px = x
            py = y
        else
            isHeld = false
        end
    love.graphics.setCanvas()
    love.graphics.setColor(1, 1, 1, 1)
end

function love.draw()
    love.graphics.print("Electric Sheep Editor!", 10, 10)
    love.graphics.draw(myCanvas, 100, 100)
end