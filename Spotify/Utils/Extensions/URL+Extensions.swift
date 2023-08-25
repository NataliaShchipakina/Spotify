//
//  URL+Extensions.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 24.08.2023.
//

import Foundation

extension URL {
    /// Позволяет инициализировать URL? из String?
    /// - Parameter optionalString: Опциональная строка
    init?(optionalString: String?) {
        guard
            let string = optionalString,
            let url = URL(string: string)
        else {
            return nil
        }

        self = url
    }
}
