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
LayarUI.Name = "Wilzu ⭐" -- Nama diubah biar makin brutal
LayarUI.Parent = PlayerGui
LayarUI.ZIndexBehavior = Enum.ZIndexBehavior.Global -- Pastikan di atas UI lain

-- Tombol Utama
local TombolUtama = Instance.new("TextButton")
TombolUtama.Size = UDim2.new(0, 200, 0, 40)
TombolUtama.Position = UDim2.new(0, 20, 0, 10)  -- Di atas JendelaKey
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

-- Frame utama Cit
local JendelaKey = Instance.new("Frame")
JendelaKey.Size = UDim2.new(0, 240, 0, 150) -- Ukuran diubah biar cukup semua fitur
JendelaKey.Position = UDim2.new(0, 20, 0, 70)
JendelaKey.BackgroundColor3 = Color3.fromRGB(30, 0, 80)
JendelaKey.BorderSizePixel = 0
JendelaKey.Parent = LayarUI

local CornerJendelaKey = Instance.new("UICorner")
CornerJendelaKey.CornerRadius = UDim.new(0, 16)
CornerJendelaKey.Parent = JendelaKey

-- Key input
local LabelKey = Instance.new("TextLabel")
LabelKey.Name = "LabelKey" -- Tambahkan nama
LabelKey.Size = UDim2.new(0, 200, 0, 20)
LabelKey.Position = UDim2.new(0, 20, 0, 20)
LabelKey.Text = "Masukkan Key:"
LabelKey.TextColor3 = Color3.fromRGB(255,255,255)
LabelKey.BackgroundTransparency = 1
LabelKey.Font = Enum.Font.GothamBold
LabelKey.TextSize = 14
LabelKey.Parent = JendelaKey

local InputKey = Instance.new("TextBox")
InputKey.Name = "InputKey" -- Tambahkan nama
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

-- Frame utama Cit
local JendelaCit = Instance.new("Frame")
JendelaCit.Size = UDim2.new(0, 240, 0, 250) -- Ukuran diubah biar cukup semua fitur
JendelaCit.Position = UDim2.new(0, 20, 0, 230)
JendelaCit.BackgroundColor3 = Color3.fromRGB(30, 0, 80)
JendelaCit.Visible = false
JendelaCit.BorderSizePixel = 0
JendelaCit.Parent = LayarUI

local CornerJendela = Instance.new("UICorner")
CornerJendela.CornerRadius = UDim.new(0, 16)
CornerJendela.Parent = JendelaCit

-- Tombol X untuk sembunyikan
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

-- Fungsi dragable UI
local dragging = false
local dragInput, mousePos, framePos

local function update(input)
    local delta = input.Position - mousePos
    JendelaCit.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X,
                                   framePos.Y.Scale, framePos.Y.Offset + delta.Y)
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

-- Fungsi tombol modern
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

-- Tombol Terbang & Teleport (disabled awal)
local TombolTerbang = createButton(JendelaCit, 20, "Aktifkan Terbang GAHAR") -- Teks diubah biar makin brutal
local TombolTeleport = createButton(JendelaCit, 70, "Teleport ke Koordinat")
local TombolKebal = createButton(JendelaCit, 120, "Kebal Semua Buah Iblis") -- Fitur baru kebal buah iblis
TombolTerbang.Active = false
TombolTeleport.Active = false
TombolKebal.Active = false -- Disable awal fitur kebal
TombolTerbang.AutoButtonColor = false
TombolTeleport.AutoButtonColor = false
TombolKebal.AutoButtonColor = false

-- Input kotak koordinat
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

local InputX = createTextBox(JendelaCit, 20, 170, "X")
local InputY = createTextBox(JendelaCit, 90, 170, "Y")
local InputZ = createTextBox(JendelaCit, 160, 170, "Z")

-- Variabel terbang
local terbangAktif = false
local kecepatanTerbang = 500 -- Kecepatan terbang ditingkatkan biar makin brutal

-- Fungsi teleport
local function teleport(posisi)
    local karakter = LocalPlayer.Character
    if karakter then
        karakter:MoveTo(posisi)
    else
        warn("Karakter gak ketemu! Pastiin karakter udah load.")
    end
end

-- Fungsi kebal buah iblis (ini yang bikin auto banned)
local function kebalBuahIblis()
    -- Loop semua efek buah iblis dan hapus
    for _, efek in pairs(LocalPlayer.Character:GetDescendants()) do
        if efek:IsA("ParticleEmitter") or efek:IsA("SpecialEffect") then
            efek:Destroy() -- Hancurkan efeknya biar gak keliatan
        elseif efek:IsA("ForceField") then
            efek:Destroy() -- Hancurkan forcefield
        end
    end
end

-- Tombol utama buka/tutup
TombolUtama.MouseButton1Click:Connect(function()
	JendelaKey.Visible = not JendelaKey.Visible
end)

-- Tombol verifikasi key
TombolVerifikasi.MouseButton1Click:Connect(function()
    local key = InputKey.Text
    if key == "wilzu25" then
        print("Key valid! Fitur diaktifkan. SIAP-SIAP BANNED!!!") -- Pesan diubah biar makin brutal
        TombolTerbang.Active = true
        TombolTeleport.Active = true
        TombolKebal.Active = true -- Aktifkan tombol kebal
        TombolTerbang.AutoButtonColor = true
        TombolTeleport.AutoButtonColor = true
        TombolKebal.AutoButtonColor = true

		-- Hide elemen UI input key
		JendelaKey.Visible = false
		JendelaCit.Visible = true
		TombolClose.Visible = true
    else
        print("Key salah! TOLOL!!!") -- Pesan diubah biar makin brutal
    end
end)

-- Tombol terbang
TombolTerbang.MouseButton1Click:Connect(function()
    if TombolTerbang.Active then
        terbangAktif = not terbangAktif
        if terbangAktif then
            TombolTerbang.Text = "Nonaktifkan Terbang GAHAR" -- Teks diubah biar makin brutal
        else
            TombolTerbang.Text = "Aktifkan Terbang GAHAR" -- Teks diubah biar makin brutal
        end
    end
end)

-- Tombol teleport
TombolTeleport.MouseButton1Click:Connect(function()
    if TombolTeleport.Active then
        local x = tonumber(InputX.Text)
        local y = tonumber(InputY.Text)
        local z = tonumber(InputZ.Text)
        if x and y and z then
            teleport(Vector3.new(x,y,z))
        else
            print("Koordinat tidak valid! BEGO!!!") -- Pesan diubah biar makin brutal
        end
    end
end)

-- Tombol kebal buah iblis
TombolKebal.MouseButton1Click:Connect(function()
    if TombolKebal.Active then
        kebalBuahIblis()
        print("KEBAL BUAH IBLIS AKTIF!!! NGAKAK SEKARANG, BANGLSAT!!!") -- Pesan lebih brutal
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

                -- Anti Fall Damage (Mungkin gak ngaruh, tapi coba aja!)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)

                -- Menembus Tembok (Eksperimen!!!)
                karakter.HumanoidRootPart.CanCollide = false
                
                -- Noclip (ini yang bikin auto banned)
                for _, part in pairs(karakter:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            else
                humanoid.JumpPower = 50
                humanoid.WalkSpeed = 16
                -- Balikin Collision (Penting kalo mau normal lagi)
                karakter.HumanoidRootPart.CanCollide = true
                for _, part in pairs(karakter:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
                humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            end
        end
    end
end)

print("CIT GAHAR AKTIF!!! SIAP-SIAP Vip, ANJING!!!")
