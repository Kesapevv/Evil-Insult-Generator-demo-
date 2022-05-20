//
//  Colors.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 13.05.2022.
//

import Foundation
import UIKit

enum Colors {
    case whiteBackground

    var value: UIColor {
        switch self {
        case .whiteBackground:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        }
    }

    var cgColor: CGColor {
        return self.value.cgColor
    }
}
