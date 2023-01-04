--[[message = "H4ll0 wr76"
count = 5

if count >= 5 then
    message = "Hello world!"
end

function love.draw()
    love.graphics.setFont(love.graphics.newFont(60))
    love.graphics.print(message)
end]]


function love.load()
    target = {}
    target.x = 300
    target.y = 300
    target.radius = 50


    score = 0
    timer = 10
    gameState = 1

    gameFont = love.graphics.newFont(40)

    sprites = {}
    sprites.sky= love.graphics.newImage('sprites/sky.png')
    sprites.crosshairs= love.graphics.newImage('sprites/crosshairs.png')
    sprites.target= love.graphics.newImage('sprites/target.png')
    love.mouse.setVisible(false)
    
    
end

function love.update(dt)
    if timer > 0 then
        timer= timer - dt
    end

    if timer < 0 then
        timer = 0
        gameState = 1
    end
end

function love.draw()
    
    
    love.graphics.draw(sprites.sky,0,0)
    if gameState == 2 then
        love.graphics.setColor(1, 0, 0)
        love.graphics.circle("fill", target.x, target.y, target.radius)
        love.graphics.setColor(1, 1, 1)

    
        love.graphics.setFont(gameFont)
        love.graphics.print("Score:" .. score, 5, 5)
        love.graphics.print("Timer:" .. math.ceil(timer), 300, 5)

        love.graphics.draw(sprites.target, target.x-50, target.y-50)
    end
    
    if gameState == 1 then
        local menuFont= love.graphics.newFont(80)
        love.graphics.setFont(menuFont)
        love.graphics.print("START", love.graphics.getWidth() /2- menuFont:getWidth("START")/2,love.graphics.getHeight()/2 - menuFont:getHeight("START")/2)
    end

    love.graphics.draw(sprites.crosshairs, love.mouse.getX()-20, love.mouse.getY()-20)
    
end

function love.mousepressed( x, y, button, istouch, presses )
    if button == 1 and gameState == 2 then
        if distanceBetween(x,target.x,y,target.y) < target.radius then
            score = score + 1
            target.x = math.random(0 + target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(0 + target.radius, love.graphics.getHeight() - target.radius)
        end
    end

    if button == 1 and gameState == 1 then
        gameState = 2
    end

end

function distanceBetween(x1,x2,y1,y2)
    return math.sqrt ((x1-x2)^2+(y1-y2)^2)
end