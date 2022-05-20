//
//  Colors.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 13.05.2022.
//

import Foundation
import UIKit

enum Colors {
    case black
    case white
    case semiwhite
    case semiblack
    
    var value: UIColor {
        switch self {
        case .semiwhite:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        case .black:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        case .semiblack:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        case .white:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        }
    }
    
    var cgColor: CGColor {
        return self.value.cgColor
    }
}
