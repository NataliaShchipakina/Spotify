//
//  UserDefaultsCore.swift
//  Spotify
//
//  Created by Eugene Dudkin on 19.07.2023.
//

import Foundation

final class UserDefaultsStorage: IStorageManager {
    
    static let shared = UserDefaultsStorage()

    // MARK: - IStorageManager
    
    /// Получаем данные из userDefaults
    /// - Parameter key: Ключ
    /// - Returns: Данные
    func get<T: Codable>(key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }

        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    /// Сохраняем данные по определенному ключу
    /// - Parameters:
    ///   - key: Ключ
    ///   - value: Данные
    func set<T: Codable>(key: String, value: T) {
        guard let data = try? JSONEncoder().encode(value) else {
            return
        }

        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    /// Удаляем данные из UserDefaults
    /// - Parameter key: Ключ
    func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}
