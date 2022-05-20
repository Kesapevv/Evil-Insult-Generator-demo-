//
//  InsultModel.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 12.05.2022.
//

import Foundation


struct InsultModel: Codable {
    
    var currentInsult = String()
    
    enum CodingKeys: String, CodingKey {
             case currentInsult = "insult"
       }
    
}
