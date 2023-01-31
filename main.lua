local canvas = {width = 600, height = 300}

local BUTTON_SIZE = 64

penColor = {1, 0, 0, 1}

function setColourGreen()
    penColor = {0, 1, 0, 1}
end

function setColourRed()
    penColor = {1, 0, 0, 1}
end

function setColourBlue()
    penColor = {0, 0, 1, 1}
end

local
function newButton(text, fn)
    return {
        text = text,
        fn = fn,
        now = false,
        last = false
    }
end

local buttons = {}

table.insert(buttons, newButton(
    "Green",
    function()
        setColourGreen()
    end
))
table.insert(buttons, newButton(
    "Red",
    function()
        setColourRed()
    end
))
table.insert(buttons, newButton(
    "Blue",
    function()
        setColourBlue()
    end
))

function love.load()
    font = love.graphics.newFont(12)

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
        if love.mouse.isDown(1) then
            local x = love.mouse.getX() - 100
            local y = love.mouse.getY() - 100
            if isHeld then
                love.graphics.setColor(unpack(penColor))
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

    local ww = love.graphics.getWidth()
    local wh = love.graphics.getHeight()
    local buffer = 16

    
    for i, button in ipairs(buttons) do 
        button.last = button.now

        local bx = buffer + (i-1) * (BUTTON_SIZE + buffer)
        local by = wh - buffer - BUTTON_SIZE
        
        local mx, my = love.mouse.getPosition()
        local hot = mx > bx and mx < bx + BUTTON_SIZE and my > by and my < by + BUTTON_SIZE

        button.now = love.mouse.isDown(1)
        if button.now and not button.last and hot then
            button.fn()
        end

        if hot then
            love.graphics.setColor(0.8, 0.8, 0.5, 1)
        else
            love.graphics.setColor(0.4, 0.4, 0.5, 1)
        end
        love.graphics.rectangle("fill", bx, by, BUTTON_SIZE, BUTTON_SIZE)

        local textW = font:getWidth(button.text)
        local textH = font:getHeight(button.text)

        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.print(button.text, font, bx + BUTTON_SIZE / 2 - textW / 2, by + BUTTON_SIZE / 2 - textH / 2)
    end
end