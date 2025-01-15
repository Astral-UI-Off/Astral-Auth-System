-- hwid_api.lua

local HttpService = game:GetService("HttpService")

local HWIDAPI = {}

-- Fonction pour crypter l'ID du joueur
local function encryptID(playerID)
    local tablecrypt = {
        ['0'] = '2', ['1'] = '1', ['2'] = '8', ['3'] = '4',
        ['4'] = '5', ['5'] = '3', ['6'] = '6', ['7'] = '0',
        ['8'] = '7', ['9'] = '9'
    }

    local playerIDStr = tostring(playerID)
    local encryptedID = ""

    for i = 1, #playerIDStr do
        local char = playerIDStr:sub(i, i)
        encryptedID = encryptedID .. tablecrypt[char]
    end
    
    return encryptedID
end

-- Fonction pour décrypter l'ID
local function decryptID(encryptedID)
    local tabledecrypt = {
        ['2'] = '0', ['1'] = '1', ['8'] = '2', ['4'] = '3',
        ['5'] = '4', ['3'] = '5', ['6'] = '6', ['0'] = '7',
        ['7'] = '8', ['9'] = '9'
    }
    
    local decryptedID = ""
    
    for i = 1, #encryptedID do
        local char = encryptedID:sub(i, i)
        decryptedID = decryptedID .. tabledecrypt[char]
    end
    
    return decryptedID
end

-- Fonction pour générer un HWID personnalisé
function HWIDAPI.generateCustomHWID(playerID)
    local encryptedID = encryptID(playerID)

    local randomPartie1 = tostring(math.random(1000, 9999))
    local randomPartie2 = tostring(math.random(1000, 9999))
    local randomPartie3 = tostring(math.random(1000, 9999))
    
    local partie1 = encryptedID:sub(1, 3)
    local partie2 = encryptedID:sub(4, 7)
    local partie3 = encryptedID:sub(8, 10)
    
    local customHWID = randomPartie1 .. "-" .. partie1 .. "-" .. randomPartie2 .. "-" .. partie2 .. "-" .. randomPartie3 .. "-" .. partie3
    
    return customHWID
end

-- Fonction pour vérifier le HWID
function HWIDAPI.verifyHWID(player)
    local cryptID = HWIDAPI.generateCustomHWID(player.UserId)
    local decryptedID = decryptID(cryptID:sub(6, 8) .. cryptID:sub(15, 18) .. cryptID:sub(25, 27))

    -- Effectuer une requête pour obtenir les données JSON
    local response = HttpService:GetAsync("url_du_json") -- Remplace par l'URL de ton JSON
    local jsonData = HttpService:JSONDecode(response)

    -- Vérifie si l'ID décrypté correspond à l'ID de la whitelist
    if decryptedID == jsonData.IDWL then
        player:Kick("Accès refusé.")
    end

    -- Affiche les IDs
    print("ID crypter : " .. cryptID)
    print("ID decrypter : " .. decryptedID)
end

return HWIDAPI
