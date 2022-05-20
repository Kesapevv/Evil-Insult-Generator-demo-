//
//  Strings.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 20.05.2022.
//

import Foundation
import UIKit

enum DayNightColors {
    
    static let day = Colors.white.value
    static let night = Colors.black.value
    
}

class AppColors {
    
    static let hour = Calendar.current.component(.hour, from: Date())
    
    static func chooseStringColor() -> UIColor {
        
        switch self.hour {
        case 1...8: return DayNightColors.night
        case 8...18: return DayNightColors.day
        case 18...24: return DayNightColors.night
        default: return DayNightColors.night
        }
        
    }
    
}
