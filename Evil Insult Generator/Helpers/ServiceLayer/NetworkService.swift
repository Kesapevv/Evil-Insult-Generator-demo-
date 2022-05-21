//
//  NetworkService.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 12.05.2022.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func FetchData(completionHandler: @escaping (String, Bool) -> ())
}

final class Network: NetworkServiceProtocol {
    
    func FetchData(completionHandler: @escaping (String, Bool) -> ()) {
        AF.request("https://evilinsult.com/generate_insult.php?lang=en&type=json", method: .get).validate().responseDecodable(of: InsultModel.self) { response in
            
            switch response.result {
            case .success(let message):
                if let response = response.value?.currentInsult {
                    completionHandler(response, true)
                }
                print("result is - \(message)")
            case .failure(let error):
                completionHandler("Error", false)
                print(error)
            }
            
        }
    }
}
