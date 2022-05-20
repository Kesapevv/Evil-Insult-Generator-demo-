//
//  UILabel+.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 18.05.2022.
//

import Foundation
import UIKit

extension UILabel {

    static func insultString() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = AppFonts.regular17.font
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.lineBreakMode = .byClipping
        label.sizeToFit()
        return label

    }
}
