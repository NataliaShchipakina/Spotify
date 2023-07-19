//
//  ICachingStorage.swift
//  Spotify
//
//  Created by Eugene Dudkin on 19.07.2023.
//

public protocol IStorageManager {
    func get<T: Codable>(key: String) -> T?
    func set<T: Codable>(key: String, value: T)
    func remove(key: String)
}
