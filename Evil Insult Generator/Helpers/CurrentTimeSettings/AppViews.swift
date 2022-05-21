//
//  Views.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 20.05.2022.
//

import Foundation
import UIKit

enum ViewsColors {
    
    static let day = Colors.semiwhite.value
    static let night = Colors.semiblack.value
    
}

final class AppViews {
    
    static let hour = Calendar.current.component(.hour, from: Date())
    
    static func chooseViewColor() -> UIColor {
        
        switch self.hour {
        case 1...8: return ViewsColors.night
        case 8...18: return ViewsColors.day
        case 18...24: return ViewsColors.night
        default: return ViewsColors.night
        }
        
    }
    
}
