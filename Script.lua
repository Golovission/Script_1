local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "PornoMenu"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

-- Стили для меню
local colors = {
    background = Color3.fromRGB(30, 30, 40),
    header = Color3.fromRGB(45, 45, 60),
    button = Color3.fromRGB(70, 70, 90),
    buttonHover = Color3.fromRGB(90, 90, 120),
    accent = Color3.fromRGB(180, 80, 180),
    text = Color3.fromRGB(240, 240, 240)
}

-- Координаты уровней (X, Y, Z + матрица поворота)
local levels = {
    CFrame.new(-741.581421, 133.56633, 8.23996544, -1.1920929e-07, 0, -1.00000012, 0, 1, 0, 1.00000012, 0, -1.1920929e-07),
    CFrame.new(-1490.5199, 29.2500763, -13.5899935, 0, 0, -1, 0, 1, 0, 1, 0, 0),
    CFrame.new(-424.815765, 16.0000572, -6.00001621, 0, 0, -1, 0, 1, 0, 1, 0, 0),
    CFrame.new(-894.374084, 189.700119, 16.1900539, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    CFrame.new(-1922.27258, 47.0700493, -329.474457, 0, 0, -1, 0, 1, 0, 1, 0, 0),
    CFrame.new(-1454.00586, 4.00005674, -54.8000107, 0, 0, -1, 0, 1, 0, 1, 0, 0),
    CFrame.new(1736.90295, 20.1610889, 371.930359, -0.38268733, 0, 0.923877954, 0, 1, 0, -0.923877954, 0, -0.38268733),
    CFrame.new(41.9999275, 50.7538147, -1207.35388, -1, 0, 0, 0, 1, 0, 0, 0, -1),
    CFrame.new(1885.10181, 44.7537727, -494.971161, 0, 0, 1, 0, 1, 0, -1, 0, 0),
    CFrame.new(-297.003326, 432.720856, -137.517838, -1, 0, 0, 0, 1, 0, 0, 0, -1),
    CFrame.new(-332.524567, 111.349419, 3776.69922, 1, 0, 0, 0, 1, 0, 0, 0, 1)
}

-- Основной фрейм меню
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 40)
frame.Position = UDim2.new(0.5, -125, 0, 20)
frame.BackgroundColor3 = colors.background
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = gui

-- Скругление углов
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

-- Заголовок меню (перетаскиваемая область)
local header = Instance.new("TextButton")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = colors.header
header.BorderSizePixel = 0
header.Text = "☰  Porno Menu  ☰"
header.TextColor3 = colors.accent
header.Font = Enum.Font.GothamBold
header.TextSize = 16
header.Parent = frame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 8)
headerCorner.Parent = header

-- Контент меню
local content = Instance.new("Frame")
content.Size = UDim2.new(1, 0, 0, 300)
content.Position = UDim2.new(0, 0, 0, 40)
content.BackgroundColor3 = colors.background
content.BorderSizePixel = 0
content.Visible = false
content.Parent = frame

-- Прокручиваемая область для кнопок уровней
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -40)
scrollFrame.Position = UDim2.new(0, 0, 0, 0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 5
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #levels * 40)
scrollFrame.Parent = content

-- Функция для создания кнопок
local function createButton(text, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = colors.button
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = colors.text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.AutoButtonColor = false
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    -- Эффекты при наведении
    btn.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = colors.buttonHover}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = colors.button}):Play()
    end)
    
    btn.MouseButton1Down:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = colors.accent}):Play()
    end)
    
    btn.MouseButton1Up:Connect(function()
        game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = colors.buttonHover}):Play()
    end)
    
    return btn
end

-- Создаем кнопки для каждого уровня
for i, levelCF in ipairs(levels) do
    local btn = createButton("Level "..i, (i-1)*40)
    btn.Parent = scrollFrame
    
    btn.MouseButton1Click:Connect(function()
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local root = humanoid.RootPart
                if root then
                    -- Анимация кнопки
                    btn.Text = "Teleporting..."
                    game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = colors.accent}):Play()
                    
                    -- Телепортация
                    root.CFrame = levelCF
                    
                    -- Возврат кнопки в исходное состояние
                    wait(0.5)
                    btn.Text = "Level "..i
                    game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = colors.button}):Play()
                end
            end
        end
    end)
end

-- Кнопка информации о создателе
local creatorBtn = createButton("Creator: PORNO", #levels*40 + 5)
creatorBtn.Parent = scrollFrame

-- Кнопка закрытия
local closeBtn = createButton("Close Menu", #levels*40 + 45)
closeBtn.Parent = content

-- Логика перетаскивания
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Логика открытия/закрытия меню
local isOpen = false
header.MouseButton1Click:Connect(function()
    if not dragging then
        isOpen = not isOpen
        content.Visible = isOpen
        
        if isOpen then
            game:GetService("TweenService"):Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 250, 0, 340)}):Play()
        else
            game:GetService("TweenService"):Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 250, 0, 40)}):Play()
        end
    end
end)

-- Логика закрытия через кнопку
closeBtn.MouseButton1Click:Connect(function()
    isOpen = false
    game:GetService("TweenService"):Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 250, 0, 40)}):Play()
    wait(0.3)
    content.Visible = false
end)

-- Кнопка создателя
creatorBtn.MouseButton1Click:Connect(function()
    creatorBtn.Text = "Creator: PORNO <3"
    game:GetService("TweenService"):Create(creatorBtn, TweenInfo.new(0.2), {BackgroundColor3 = colors.accent}):Play()
    wait(1)
    creatorBtn.Text = "Creator: PORNO"
    game:GetService("TweenService"):Create(creatorBtn, TweenInfo.new(0.2), {BackgroundColor3 = colors.button}):Play()
end)
