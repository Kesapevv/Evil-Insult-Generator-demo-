//
//  Image.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 20.05.2022.
//

import Foundation

enum ImagesNames {
    
    static let day = "day"
    static let night = "night"
    
    static let libraryDay = "libraryDay"
    static let libraryNight = "libraryNight"
    
}

class BackgroundImage {
    
    static let hour = Calendar.current.component(.hour, from: Date())
    
    static func chooseDayImage() -> String {
        
        switch self.hour {
        case 1...8: return ImagesNames.night
        case 8...18: return ImagesNames.day
        case 18...24: return ImagesNames.night
        default: return "errorPicture"
        }
    }
    
    static func chooseLibraryImage() -> String {
        
        switch self.hour {
        case 1...8: return ImagesNames.libraryNight
        case 8...18: return ImagesNames.libraryDay
        case 18...24: return ImagesNames.libraryNight
        default: return "errorPicture"
        }
    }
}
