//
//  AppFonts.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 13.05.2022.
//

import Foundation
import UIKit

enum AppFonts {
    case regular17
    case regular15

    var font: UIFont? {
        switch self {
        case .regular17:
            return UIFont(name: "PressStart2P-Regular", size: 17)
        case .regular15:
            return UIFont(name: "PressStart2P-Regular", size: 15)
        }
    }
}
