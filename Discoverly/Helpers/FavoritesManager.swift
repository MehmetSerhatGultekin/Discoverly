//
//  FavoritesManager.swift
//  Discoverly
//
//  Created by Mehmet Serhat Gültekin on 22.07.2025.
//

import Foundation

final class FavoritesManager {
    static let shared = FavoritesManager()
    private init() {
        loadFavorites()
    }

   
    private var favorites: [Content] = []

    // MARK: Public Methods

    func addToFavorites(_ content: Content) {
        if !favorites.contains(where: { $0.title == content.title }) {
            favorites.append(content)
            saveFavorites()
        }
    }

    func removeFromFavorites(_ content: Content) {
        favorites.removeAll { $0.title == content.title }
        saveFavorites()
    }

    func isFavorite(_ content: Content) -> Bool {
        return favorites.contains { $0.title == content.title }
    }

    func getAllfavorites() -> [Content] {
        return favorites
    }

    /// Clears all saved favorites, persists the change, and notifies observers.
    func clearAllFavorites() {
        // Remove all items from the in-memory list
        favorites.removeAll()
        // Persist the cleared list
        saveFavorites()
        // Notify observers that favorites have been updated
        NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
    }

    // MARK: Persistence

    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: Constants.Keys.favoritesKey)
        }
    }

    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: Constants.Keys.favoritesKey),
           let savedFavorites = try? JSONDecoder().decode([Content].self, from: data) {
            favorites = savedFavorites
        }
    }
}



// MARK: GENEL NOTLAR
/*
 Singleton Pattern Nedir?
 Bir sınıftan (class) uygulama boyunca sadece bir tane instance (örnek) oluşturmak istiyorsan, singleton kullanırsın.

  Neden kullanılır?
     •    Merkezi veri yönetimi gerekir (örneğin favori filmler, kullanıcı bilgileri, oturum durumu).
     •    Belleği korur: Tek bir instance her yerden çağrılır, her seferinde yenisi oluşturulmaz.
     •    Global erişim sağlar ama kontrollü ve güvenlidir.
 */

extension Notification.Name {
    static let favoritesUpdated = Notification.Name("favoritesUpdated")
}
