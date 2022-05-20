//
//  Extension.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 17.05.2022.
//

import Foundation
import UIKit

extension String {
    
    static func createString(_ label: String) -> NSAttributedString {
        let string = label
        let font = AppFonts.regular15.font
        let attributes = [NSAttributedString.Key.font: font]
        let attributedString = NSAttributedString(string: string, attributes: attributes as [NSAttributedString.Key : Any])
        return attributedString
    }
    
    static func timeString(time: TimeInterval) -> String {
             let hour = Int(time) / 3600
             let minute = Int(time) / 60 % 60
             let second = Int(time) % 60
             return String(format: "%02i:%02i:%02i", hour, minute, second)
     }
    
    static func stringConfig(_ label: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.35
        paragraphStyle.alignment = .center

        let string = NSMutableAttributedString(string: label, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        return string
    }
    
}


