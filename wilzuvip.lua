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

-- Frame verifikasi key
local JendelaKey = Instance.new("Frame")
JendelaKey.Size = UDim2.new(0, 240, 0, 150)
JendelaKey.Position = UDim2.new(0, 20, 0, 20)
JendelaKey.BackgroundColor3 = Color3.fromRGB(30, 0, 80)
JendelaKey.BorderSizePixel = 0
JendelaKey.Parent = LayarUI

local CornerJendelaKey = Instance.new("UICorner")
CornerJendelaKey.CornerRadius = UDim.new(0, 16)
CornerJendelaKey.Parent = JendelaKey

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

-- Tombol close di frame key
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

-- FRAME CIT DI POJOK KIRI ATAS
local JendelaCit = Instance.new("Frame")
JendelaCit.Size = UDim2.new(0, 240, 0, 290) -- Tinggi ditambah buat tombol fishing
JendelaCit.Position = UDim2.new(0, 20, 0, 20)
JendelaCit.BackgroundColor3 = Color3.fromRGB(30, 0, 80)
JendelaCit.Visible = false
JendelaCit.BorderSizePixel = 0
JendelaCit.Parent = LayarUI

local CornerJendela = Instance.new("UICorner")
CornerJendela.CornerRadius = UDim.new(0, 16)
CornerJendela.Parent = JendelaCit

-- Tombol close GUI CIT
local TombolCloseCit = Instance.new("TextButton")
TombolCloseCit.Size = UDim2.new(0, 30, 0, 30)
TombolCloseCit.Position = UDim2.new(1, -35, 0, 5)
TombolCloseCit.Text = "X"
TombolCloseCit.TextColor3 = Color3.fromRGB(255,0,0)
TombolCloseCit.BackgroundColor3 = Color3.fromRGB(50,50,50)
TombolCloseCit.Font = Enum.Font.GothamBold
TombolCloseCit.TextSize = 18
TombolCloseCit.BorderSizePixel = 0
TombolCloseCit.Parent = JendelaCit

local CornerCloseCit = Instance.new("UICorner")
CornerCloseCit.CornerRadius = UDim.new(0,5)
CornerCloseCit.Parent = TombolCloseCit

TombolCloseCit.MouseButton1Click:Connect(function()
	JendelaCit.Visible = false
end)

-- Fungsi buat tombol
local function createButton(parent, posisiY, teks)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 200, 0, 40)
	btn.Position = UDim2.new(0, 20, 0, posisiY)
	btn.Text = teks
	btn.BackgroundColor3 = Color3.fromRGB(120,0,255)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.BorderSizePixel = 0
	btn.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,10)
	corner.Parent = btn

	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(180,0,255)
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(120,0,255)
	end)
	return btn
end

-- Tombol utama CIT
local TombolTerbang = createButton(JendelaCit, 20, "Aktifkan Terbang GAHAR")
local TombolTeleport = createButton(JendelaCit, 70, "Teleport ke Koordinat")
local TombolKebal = createButton(JendelaCit, 120, "Kebal Semua Buah Iblis")
local TombolFishingPerfect = createButton(JendelaCit, 170, "Fishing AUTO PERFECT 🎣") -- Tombol Fishing Perfect
TombolTerbang.Active = false
TombolTeleport.Active = false
TombolKebal.Active = false
TombolFishingPerfect.Active = false -- Awalnya non-aktif
TombolTerbang.AutoButtonColor = false
TombolTeleport.AutoButtonColor = false
TombolKebal.AutoButtonColor = false
TombolFishingPerfect.AutoButtonColor = false

-- Input koordinat
local function createTextBox(parent, posisiX, posisiY, placeholder)
	local tb = Instance.new("TextBox")
	tb.Size = UDim2.new(0, 60, 0, 30)
	tb.Position = UDim2.new(0, posisiX, 0, posisiY)
	tb.PlaceholderText = placeholder
	tb.BackgroundColor3 = Color3.fromRGB(60,0,120)
	tb.TextColor3 = Color3.fromRGB(255,255,255)
	tb.Font = Enum.Font.Gotham
	tb.TextSize = 16
	tb.BorderSizePixel = 0
	tb.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0,6)
	corner.Parent = tb
	return tb
end

local InputX = createTextBox(JendelaCit, 20, 220, "X") -- Dipindah ke bawah fishing
local InputY = createTextBox(JendelaCit, 90, 220, "Y")
local InputZ = createTextBox(JendelaCit, 160, 220, "Z")

-- Variabel
local terbangAktif = false
local kecepatanTerbang = 500
local fishingPerfectAktif = false -- Variabel buat fishing perfect

local function teleport(posisi)
	local karakter = LocalPlayer.Character
	if karakter then
		karakter:MoveTo(posisi)
	end
end

local function kebalBuahIblis()
	for _, efek in pairs(LocalPlayer.Character:GetDescendants()) do
		if efek:IsA("ParticleEmitter") or efek:IsA("SpecialEffect") or efek:IsA("ForceField") then
			efek:Destroy()
		end
	end
end

-- Fungsi buat fishing perfect (PERHATIKAN INI!)
local function fishingPerfect()
	fishingPerfectAktif = not fishingPerfectAktif
	TombolFishingPerfect.Text = fishingPerfectAktif and "Fishing PERFECT ON ✅" or "Fishing AUTO PERFECT 🎣"
	if fishingPerfectAktif then
		print("Fishing perfect diaktifkan! Nikmati hasil tangkapan yang mantap!")
		-- Ganti nilai probabilitas item di game (CARA PALING BANJINGAN)
		-- PASTIKAN LO TAU NAMA ITEM ATAU NILAI YANG MAU DIUBAH!
		-- CONTOH: game.ServerScriptService.FishingSystem.RareFishProbability.Value = 1
		-- Ganti "RareFishProbability" dengan nama variabel probabilitas yang BENAR!
		-- WARNING: Kode ini berbahaya dan bisa ngerusak game! Gunakan dengan hati-hati!
	else
		print("Fishing perfect dinonaktifkan.")
		-- Balikin nilai probabilitas ke semula (opsional)
		-- CONTOH: game.ServerScriptService.FishingSystem.RareFishProbability.Value = 0.05
	end
end

-- Verifikasi key
TombolVerifikasi.MouseButton1Click:Connect(function()
	local key = InputKey.Text
	if key == "wilzu25" then
		print("Key valid! Fitur aktif.")
		JendelaKey.Visible = false
		JendelaCit.Visible = true
		TombolTerbang.Active = true
		TombolTeleport.Active = true
		TombolKebal.Active = true
		TombolFishingPerfect.Active = true -- Aktifin tombol fishing perfect
		TombolTerbang.AutoButtonColor = true
		TombolTeleport.AutoButtonColor = true
		TombolKebal.AutoButtonColor = true
		TombolFishingPerfect.AutoButtonColor = true -- Set auto button color
	else
		print("Key salah!")
	end
end)

-- Fungsi tombol
TombolTerbang.MouseButton1Click:Connect(function()
	if TombolTerbang.Active then
		terbangAktif = not terbangAktif
		TombolTerbang.Text = terbangAktif and "Terbang OFF 🔴" or "Terbang ON 🕊️"
	end
end)

TombolTeleport.MouseButton1Click:Connect(function()
	if TombolTeleport.Active then
		local x = tonumber(InputX.Text)
		local y = tonumber(InputY.Text)
		local z = tonumber(InputZ.Text)
		if x and y and z then
			teleport(Vector3.new(x, y, z))
		else
			print("Koordinat tidak valid!")
		end
	end
end)

TombolKebal.MouseButton1Click:Connect(function()
	if TombolKebal.Active then
		kebalBuahIblis()
		print("Kebal Buah Iblis aktif!")
	end
end)

-- Tombol Fishing Perfect
TombolFishingPerfect.MouseButton1Click:Connect(function()
	if TombolFishingPerfect.Active then
		fishingPerfect() -- Panggil fungsi fishing perfect
	end
end)

-- Logika terbang
RunService.Stepped:Connect(function()
	local karakter = LocalPlayer.Character
	if karakter and karakter:FindFirstChild("HumanoidRootPart") and karakter:FindFirstChild("Humanoid") then
		local humanoid = karakter:FindFirstChild("Humanoid")
		if humanoid then
			if terbangAktif then
				humanoid.JumpPower = 0
				humanoid.WalkSpeed = kecepatanTerbang
				karakter.HumanoidRootPart.Velocity = Vector3.new(0, kecepatanTerbang, 0)
				humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
				karakter.HumanoidRootPart.CanCollide = false
				for _, part in pairs(karakter:GetDescendants()) do
					if part:IsA("BasePart") then part.CanCollide = false end
				end
			else
				humanoid.JumpPower = 50
				humanoid.WalkSpeed = 16
				humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
				for _, part in pairs(karakter:GetDescendants()) do
					if part:IsA("BasePart") then part.CanCollide = true end
				end
			end
		end
	end
end)

print("UI CIT pojok kiri aktif ✅")
