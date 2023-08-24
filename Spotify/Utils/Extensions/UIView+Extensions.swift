//
//  UIView+Extensions.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 04.07.2023.
//

import Foundation
import UIKit

extension UIView {
    /// Return view width
    var width: CGFloat {
        return frame.size.width
    }
    
    /// Return view height
    var height: CGFloat {
        return frame.size.height
    }
    
    /// Return left view parameter
    var left: CGFloat {
        return frame.origin.x
    }
    
    /// Return top view parameter
    var top: CGFloat {
        return frame.origin.y
    }
    
    /// Return bottom view parameter
    var bottom: CGFloat {
        return top + height
    }
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

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


