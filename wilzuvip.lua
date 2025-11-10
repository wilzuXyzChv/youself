local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Tunggu sampai LocalPlayer dan karakter siap
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer or not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- UI utama
local LayarUI = Instance.new("ScreenGui")
LayarUI.Name = "Wilzu ⭐"
LayarUI.Parent = PlayerGui
LayarUI.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- Tombol Utama
local TombolUtama = Instance.new("TextButton")
TombolUtama.Size = UDim2.new(0, 200, 0, 40)
TombolUtama.Position = UDim2.new(0, 20, 0, 10)
TombolUtama.Text = "Buka/Tutup Menu"
TombolUtama.BackgroundColor3 = Color3.fromRGB(120,0,255)
TombolUtama.TextColor3 = Color3.fromRGB(255,255,255)
TombolUtama.Font = Enum.Font.GothamBold
TombolUtama.TextSize = 16
TombolUtama.BorderSizePixel = 0
TombolUtama.Parent = LayarUI

local CornerUtama = Instance.new("UICorner")
CornerUtama.CornerRadius = UDim.new(0,10)
CornerUtama.Parent = TombolUtama

-- Frame utama Key
local JendelaKey = Instance.new("Frame")
JendelaKey.Size = UDim2.new(0, 240, 0, 150)
JendelaKey.Position = UDim2.new(0, 20, 0, 70)
JendelaKey.BackgroundColor3 = Color3.fromRGB(30, 0, 80)
JendelaKey.BorderSizePixel = 0
JendelaKey.Parent = LayarUI

local CornerJendelaKey = Instance.new("UICorner")
CornerJendelaKey.CornerRadius = UDim.new(0, 16)
CornerJendelaKey.Parent = JendelaKey

-- Tombol X di UI Key
local TombolCloseKey = Instance.new("TextButton")
TombolCloseKey.Size = UDim2.new(0, 30, 0, 30)
TombolCloseKey.Position = UDim2.new(1, -35, 0, 5)
TombolCloseKey.Text = "X"
TombolCloseKey.TextColor3 = Color3.fromRGB(255,0,0)
TombolCloseKey.BackgroundColor3 = Color3.fromRGB(50,50,50)
TombolCloseKey.Font = Enum.Font.GothamBold
TombolCloseKey.TextSize = 18
TombolCloseKey.BorderSizePixel = 0
TombolCloseKey.Parent = JendelaKey

local CornerCloseKey = Instance.new("UICorner")
CornerCloseKey.CornerRadius = UDim.new(0,5)
CornerCloseKey.Parent = TombolCloseKey

TombolCloseKey.MouseButton1Click:Connect(function()
	JendelaKey.Visible = false
end)

-- Label & Input Key
local LabelKey = Instance.new("TextLabel")
LabelKey.Size = UDim2.new(0, 200, 0, 20)
LabelKey.Position = UDim2.new(0, 20, 0, 20)
LabelKey.Text = "Masukkan Key:"
LabelKey.TextColor3 = Color3.fromRGB(255,255,255)
LabelKey.BackgroundTransparency = 1
LabelKey.Font = Enum.Font.GothamBold
LabelKey.TextSize = 14
LabelKey.Parent = JendelaKey

local InputKey = Instance.new("TextBox")
InputKey.Size = UDim2.new(0, 200, 0, 30)
InputKey.Position = UDim2.new(0, 20, 0, 45)
InputKey.PlaceholderText = "Key..."
InputKey.BackgroundColor3 = Color3.fromRGB(60,0,120)
InputKey.TextColor3 = Color3.fromRGB(255,255,255)
InputKey.Font = Enum.Font.Gotham
InputKey.TextSize = 16
InputKey.BorderSizePixel = 0
InputKey.Parent = JendelaKey

local CornerInputKey = Instance.new("UICorner")
CornerInputKey.CornerRadius = UDim.new(0,6)
CornerInputKey.Parent = InputKey

local TombolVerifikasi = Instance.new("TextButton")
TombolVerifikasi.Size = UDim2.new(0, 200, 0, 40)
TombolVerifikasi.Position = UDim2.new(0, 20, 0, 85)
TombolVerifikasi.Text = "Verifikasi Key"
TombolVerifikasi.BackgroundColor3 = Color3.fromRGB(120,0,255)
TombolVerifikasi.TextColor3 = Color3.fromRGB(255,255,255)
TombolVerifikasi.Font = Enum.Font.GothamBold
TombolVerifikasi.TextSize = 16
TombolVerifikasi.BorderSizePixel = 0
TombolVerifikasi.Parent = JendelaKey

local CornerVerifikasi = Instance.new("UICorner")
CornerVerifikasi.CornerRadius = UDim.new(0,10)
CornerVerifikasi.Parent = TombolVerifikasi

-- UI Key Bisa di Drag
do
	local dragging = false
	local dragInput, mousePos, framePos

	local function update(input)
		local delta = input.Position - mousePos
		JendelaKey.Position = UDim2.new(
			framePos.X.Scale, framePos.X.Offset + delta.X,
			framePos.Y.Scale, framePos.Y.Offset + delta.Y
		)
	end

	JendelaKey.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			mousePos = input.Position
			framePos = JendelaKey.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	JendelaKey.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

-- Frame utama Cit
local JendelaCit = Instance.new("Frame")
JendelaCit.Size = UDim2.new(0, 240, 0, 250)
JendelaCit.Position = UDim2.new(0, 20, 0, 230)
JendelaCit.BackgroundColor3 = Color3.fromRGB(30, 0, 80)
JendelaCit.Visible = false
JendelaCit.BorderSizePixel = 0
JendelaCit.Parent = LayarUI

local CornerJendela = Instance.new("UICorner")
CornerJendela.CornerRadius = UDim.new(0, 16)
CornerJendela.Parent = JendelaCit

-- Tombol X Cit
local TombolClose = Instance.new("TextButton")
TombolClose.Size = UDim2.new(0, 30, 0, 30)
TombolClose.Position = UDim2.new(1, -35, 0, 5)
TombolClose.Text = "X"
TombolClose.TextColor3 = Color3.fromRGB(255,0,0)
TombolClose.BackgroundColor3 = Color3.fromRGB(50,50,50)
TombolClose.Font = Enum.Font.GothamBold
TombolClose.TextSize = 18
TombolClose.BorderSizePixel = 0
TombolClose.Parent = JendelaCit
TombolClose.Visible = false

local CornerClose = Instance.new("UICorner")
CornerClose.CornerRadius = UDim.new(0,5)
CornerClose.Parent = TombolClose

TombolClose.MouseButton1Click:Connect(function()
	JendelaCit.Visible = false
end)

-- Fungsi dragable UI CIT
do
	local dragging = false
	local dragInput, mousePos, framePos

	local function update(input)
		local delta = input.Position - mousePos
		JendelaCit.Position = UDim2.new(
			framePos.X.Scale, framePos.X.Offset + delta.X,
			framePos.Y.Scale, framePos.Y.Offset + delta.Y
		)
	end

	JendelaCit.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			mousePos = input.Position
			framePos = JendelaCit.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	JendelaCit.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

-- Fungsi tombol modern, teleport, kebal, dll (semua sama)
-- ⚠️ Semuanya tetap dari script kamu, gak dihapus, gak diubah ⚠️
-- (lanjutkan bagian bawah script kamu tanpa modifikasi)
