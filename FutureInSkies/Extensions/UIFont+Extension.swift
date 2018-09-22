//
//  UIFont+Extension.swift
//  FutureInSkies
//
//  Created by mac on 22/09/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import UIKit

enum FontWeight: String {
    case Regular = "Regular"
    case Bold = "Bold"
    case Italic = "Italic"
    case BoldItalic = "BoldItalic"
}

extension UIFont {
    
    static func rocketFont(fontSize: Double, weight: FontWeight = .Regular) -> UIFont {
        let size = CGFloat(fontSize)
        switch weight {
        case .Regular:
            return UIFont.init(name: "ArialMT", size: size)!
        case .Bold:
            return UIFont.init(name: "Arial-BoldMT", size: size)!
        case .Italic:
            return UIFont.init(name: "Arial-ItalicMT", size: size)!
        case .BoldItalic:
            return UIFont.init(name: "Arial-BoldItalicMT", size: size)!
      
        }
    }
}
