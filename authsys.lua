-- authsys.lua

local AuthSystem = {}

-- Liste des utilisateurs autorisés (whitelist)
local whitelist = {
    ["user1"] = true,
    ["user2"] = true,
    ["user3"] = true,
}

-- Clés d'accès
local keys = {
    ["key1"] = "user1",
    ["key2"] = "user2",
    -- Ajoute d'autres clés ici
}

-- Fonction pour vérifier si un utilisateur est dans la whitelist
function AuthSystem.isWhitelisted(username)
    return whitelist[username] ~= nil
end

-- Fonction pour vérifier si une clé est valide
function AuthSystem.isValidKey(key)
    return keys[key] ~= nil
end

-- Fonction d'authentification
function AuthSystem.authenticate(username, key)
    if AuthSystem.isWhitelisted(username) then
        return { success = true, message = "Connexion réussie !" }
    elseif AuthSystem.isValidKey(key) then
        return { success = true, message = "Connexion réussie avec la clé !" }
    else
        return { success = false, message = "Échec de la connexion. Clé invalide ou utilisateur non autorisé." }
    end
end

return AuthSystem
