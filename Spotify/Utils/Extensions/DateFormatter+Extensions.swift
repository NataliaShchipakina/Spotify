//
//  DateFormatter+Extensions.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.08.2023.
//

import Foundation


extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()

    static let displayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
        static func formattedDate(string: String) -> String {
            guard let date = DateFormatter.dateFormatter.date(from: string) else {
                return string
            }
            return DateFormatter.displayDateFormatter.string(from: date)
        }
    }
