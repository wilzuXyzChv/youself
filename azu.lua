-- Konfigurasi Awal
local autoRebirth = true
local sellInterval = 5
local requiredKey = "wilzu22"
local isFishing = false
local isAntiDisconnectActive = false
local mancingDelay = 7
local currentMancingDelay = mancingDelay
local isAutoDetectEnabled = true  -- Aktifkan deteksi otomatis
local deteksiThreshold = 0.95  -- Tingkat kepercayaan deteksi (0.0 - 1.0)

-- Library OpenCV (Asumsi Lo Punya Pluginnya)
local success, cv = pcall(require, "OpenCV") -- Ganti path sesuai lokasi plugin OpenCV lo
if not success then
    warn("Gagal memuat OpenCV: " .. cv)
    return -- Stop script jika OpenCV gagal dimuat
end

-- Fungsi Cek Key (Gak Usah Diubah)
local function checkKey(callback)
    local gui = Instance.new("ScreenGui")
    gui.Name = "KeyGUI"
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.5, 0, 0.3, 0)
    frame.Position = UDim2.new(0.25, 0, 0.35, 0)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BackgroundTransparency = 0.4
    frame.BorderColor3 = Color3.fromRGB(150, 0, 255)
    frame.BorderSizePixel = 2
    frame.Parent = gui

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.8, 0, 0.3, 0)
    textBox.Position = UDim2.new(0.1, 0, 0.1, 0)
    textBox.PlaceholderText = "Masukkan key"
    textBox.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
    textBox.Parent = frame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.8, 0, 0.3, 0)
    button.Position = UDim2.new(0.1, 0, 0.5, 0)
    button.Text = "Konfirmasi"
    button.BackgroundColor3 = Color3.fromRGB(200, 0, 200)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = frame

    button.MouseButton1Click:Connect(function()
        print("Tombol Konfirmasi ditekan") -- Tambahin ini

        if textBox.Text == requiredKey then
            gui:Destroy()
            print("✅ Key benar, script aktif")
            callback(true)
        else
            textBox.Text = ""
            textBox.PlaceholderText = "❌ Key Salah!"
            callback(false)
        end
    end)
end

-- Fungsi Jual Ikan (Gak Usah Diubah)
local function jualIkan()
    game:GetService("ReplicatedStorage").RemoteEvents.SellFish:FireServer()
    print("💸 Ikan dijual")
end

-- Fungsi Rebirth (Gak Usah Diubah)
local function rebirth()
    game:GetService("ReplicatedStorage").RemoteEvents.Rebirth:FireServer()
    print("♻️ Rebirth berhasil")
end

-- Fungsi Tap Layar Otomatis (Udah Di-Upgrade)
local function tapLayarOtomatis()
    -- Simulasi Pencet Spasi (Bisa Diubah Sesuai Game)
    game:GetService("UserInputService"):InputBegan(Enum.UserInputType.Keyboard, Enum.KeyCode.Space)
    wait(math.random(0.1, 0.3))  -- Variasi Durasi Pencet
    game:GetService("UserInputService"):InputEnded(Enum.UserInputType.Keyboard, Enum.KeyCode.Space)

    print("👆 Layar ditap otomatis")
end

-- Deteksi Ikan Otomatis Pake OpenCV (INI YANG PALING PENTING!)
local function deteksiIkan()
    if not isAutoDetectEnabled then return false end

    -- Ambil Screenshot Layar
    local screenshot, err = pcall(cv.captureScreenshot)
    if not screenshot then
        warn("Gagal ambil screenshot: " .. err)
        return false, nil
    end

    -- Load Template Ikan (Loe Harus Siapin Gambar Ikan Yang Mau Dideteksi)
    local templateIkan, err = pcall(cv.loadImage, "rbxassetid://[ID ASET GAMBAR IKAN LOE]") -- Ganti ID-nya!
    if not templateIkan then
        warn("Gagal load template ikan: " .. err)
        return false, nil
    end

    -- Template Matching
    local hasilMatch = cv.matchTemplate(screenshot, templateIkan, cv.TM_CCOEFF_NORMED)

    -- Cari Nilai Tertinggi (Lokasi Ikan)
    local minValue, maxValue, minLoc, maxLoc = cv.minMaxLoc(hasilMatch)

    -- Cek Tingkat Kepercayaan
    if maxValue > deteksiThreshold then
        print("✅ Ikan terdeteksi dengan tingkat kepercayaan: " .. maxValue)
        return true, maxLoc  -- Kembalikan lokasi ikan
    else
        print("❌ Tidak ada ikan terdeteksi (tingkat kepercayaan rendah)")
        return false, nil
    end
end

-- Fungsi Mancing Otomatis (Udah Di-Upgrade)
local function mancingOtomatis()
    if isFishing then
        game:GetService("ReplicatedStorage").RemoteEvents.StartFishing:FireServer()
        wait(5)

        -- Deteksi Ikan Pake OpenCV
        local ikanTerdeteksi, lokasiIkan = deteksiIkan()

        if ikanTerdeteksi then
            -- Kalo Ikan Ketemu, Tap Layar Buat Narik
            tapLayarOtomatis()

            -- Tunggu Sebentar Biar Gak Ketauan Bot
            wait(math.random(currentMancingDelay - 2, currentMancingDelay + 2))
        end

        game:GetService("ReplicatedStorage").RemoteEvents.StopFishing:FireServer()
        wait(currentMancingDelay)
    end
end

-- Fungsi Anti Diskonek (Gak Usah Diubah)
local function antiDisconnect()
    while isAntiDisconnectActive do
        wait(30)
        game:GetService("ReplicatedStorage").RemoteEvents.Heartbeat:FireServer()
        print("💜 Heartbeat terkirim (anti diskonek)")
    end
end

local function buatUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "FishItGUI"
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.22, 0, 0.47, 0)  -- Sedikit Lebih Tinggi
    frame.Position = UDim2.new(0.05, 0, 0.05, 0)
    frame.BackgroundColor3 = Color3.fromRGB(40, 0, 60)
    frame.BackgroundTransparency = 0.2
    frame.BorderColor3 = Color3.fromRGB(200, 0, 255)
    frame.BorderSizePixel = 2
    frame.Parent = gui

    -- Tombol Mancing Otomatis (Gak Usah Diubah)
    local toggleFishButton = Instance.new("TextButton")
    toggleFishButton.Size = UDim2.new(0.8, 0, 0.2, 0)
    toggleFishButton.Position = UDim2.new(0.1, 0, 0.1, 0)
    toggleFishButton.BackgroundColor3 = Color3.fromRGB(200, 0, 200)
    toggleFishButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleFishButton.Text = "🎣 Mancing Otomatis: OFF"
    toggleFishButton.Parent = frame

    wait(0.1) -- Biar UI ke-load dulu
    toggleFishButton.MouseButton1Click:Connect(function()
        isFishing = not isFishing
        if isFishing then
            toggleFishButton.Text = "🎣 Mancing Otomatis: ON"
            print("✅ Mancing Otomatis Aktif")
            spawn(function()
                while isFishing do
                    mancingOtomatis()
                    wait(1)
                end
            end)
        else
            toggleFishButton.Text = "🎣 Mancing Otomatis: OFF"
            print("❌ Mancing Otomatis Nonaktif")
        end
    end)
    local sellButton = Instance.new("TextButton")
    sellButton.Size = UDim2.new(0.8, 0, 0.2, 0)
    sellButton.Position = UDim2.new(0.1, 0, 0.33, 0)
    sellButton.BackgroundColor3 = Color3.fromRGB(200, 0, 200)
    sellButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    sellButton.Text = "💸 Jual Ikan"
    sellButton.Parent = frame
    sellButton.MouseButton1Click:Connect(jualIkan)

    -- Tombol Anti Diskonek (Gak Usah Diubah)
    local toggleAntiDisconnectButton = Instance.new("TextButton")
    toggleAntiDisconnectButton.Size = UDim2.new(0.8, 0, 0.2, 0)
    toggleAntiDisconnectButton.Position = UDim2.new(0.1, 0, 0.56, 0)
    toggleAntiDisconnectButton.BackgroundColor3 = Color3.fromRGB(200, 0, 200)
    toggleAntiDisconnectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleAntiDisconnectButton.Text = "🔒 Anti-Diskonek: OFF"
    toggleAntiDisconnectButton.Parent = frame

    toggleAntiDisconnectButton.MouseButton1Click:Connect(function()
        isAntiDisconnectActive = not isAntiDisconnectActive
        if isAntiDisconnectActive then
            toggleAntiDisconnectButton.Text = "🔒 Anti-Diskonek: ON"
            print("✅ Anti Diskonek Aktif")
            spawn(antiDisconnect)
        else
            toggleAntiDisconnectButton.Text = "🔒 Anti-Diskonek: OFF"
            print("❌ Anti Diskonek Nonaktif")
        end
    end)

    -- Tombol Set Delay (Gak Usah Diubah)
    local setDelayButton = Instance.new("TextButton")
    setDelayButton.Size = UDim2.new(0.8, 0, 0.15, 0)
    setDelayButton.Position = UDim2.new(0.1, 0, 0.8, 0)
    setDelayButton.Text = "⚙️ Set Delay"
    setDelayButton.BackgroundColor3 = Color3.fromRGB(200, 0, 200)
    setDelayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    setDelayButton.Parent = frame

    -- SLIDER Delay (Gak Usah Diubah)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0.8, 0, 0.07, 0)
    sliderFrame.Position = UDim2.new(0.1, 0, 0.95, 0)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
    sliderFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    sliderFrame.Parent = frame

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(0.05, 0, 1, 0)
    sliderBar.Position = UDim2.new(0, 0, 0, 0)
    sliderBar.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
    sliderBar.Parent = sliderFrame

    local userInput = game:GetService("UserInputService")
    local dragging = false

    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    userInput.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    userInput.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((input.Position.X - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X, 0, 1)
            sliderBar.Size = UDim2.new(rel, 0, 1, 0)
            currentMancingDelay = math.floor(1 + (119 * rel))
            print("Delay diubah jadi " .. currentMancingDelay .. " detik")
        end
    end)
    local toggleDeteksiButton = Instance.new("TextButton")
    toggleDeteksiButton.Size = UDim2.new(0.8, 0, 0.2, 0)
    toggleDeteksiButton.Position = UDim2.new(0.1, 0, 0.1 + 0.79, 0)
    toggleDeteksiButton.BackgroundColor3 = Color3.fromRGB(200, 0, 200)
    toggleDeteksiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleDeteksiButton.Text = "🤖 Deteksi Otomatis: ON"
    toggleDeteksiButton.Parent = frame

    toggleDeteksiButton.MouseButton1Click:Connect(function()
        isAutoDetectEnabled = not isAutoDetectEnabled
        if isAutoDetectEnabled then
            toggleDeteksiButton.Text = "🤖 Deteksi Otomatis: ON"
            print("✅ Deteksi Otomatis Aktif")
        else
            toggleDeteksiButton.Text = "🤖 Deteksi Otomatis: OFF"
            print("❌ Deteksi Otomatis Nonaktif")
        end
    end)

    -- Tombol X buat nutup menu (Gak Usah Diubah)
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0.15, 0, 0.15, 0)
    closeButton.Position = UDim2.new(0.82, 0, 0.03, 0)
    closeButton.Text = "X"
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Parent = frame

    closeButton.MouseButton1Click:Connect(function()
        gui:Destroy() -- Hapus GUI nya
        print("❌ Menu ditutup")
    end)
end

checkKey(function(isValid)
    if isValid then
        buatUI()
        print("💜 Script Wilzu V8.4 Aktif (Auto Detect Mode!)")
    else
        print("❌ Key salah, script tidak dijalankan")
    end
end)
