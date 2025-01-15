// auth.js

const whitelist = ["user1", "user2", "user3"]; // Liste des utilisateurs autorisés
const keys = {
    "key1": "user1",
    "key2": "user2",
    // Ajoute d'autres clés ici
};

// Fonction pour vérifier si un utilisateur est dans la whitelist
function isWhitelisted(username) {
    return whitelist.includes(username);
}

// Fonction pour vérifier si une clé est valide
function isValidKey(key) {
    return keys.hasOwnProperty(key);
}

// Fonction d'authentification
function authenticate(username, key) {
    if (isWhitelisted(username)) {
        return { success: true, message: "Connexion réussie !" };
    } else if (isValidKey(key)) {
        return { success: true, message: "Connexion réussie avec la clé !" };
    } else {
        return { success: false, message: "Échec de la connexion. Clé invalide ou utilisateur non autorisé." };
    }
}

// Exporter la fonction d'authentification
module.exports = { authenticate };
