//
//  UIImageView.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 17.05.2022.
//

import Foundation
import UIKit

public enum Images {
   
   static let day = "day"
   static let night = "library"
    
}

extension UIImageView {
    
    static func setBackgroundImage(image: String) -> UIImageView {
        let backgroundImage = UIImage(named: image)
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleToFill
        return imageView
    }
        
}
