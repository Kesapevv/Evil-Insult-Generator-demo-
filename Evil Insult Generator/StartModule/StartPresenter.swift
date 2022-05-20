//
//  StartPresenter.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 12.05.2022.
//

import Foundation
import CoreData
import UIKit

protocol StartViewProtocol: AnyObject {
    func success()
    func failure()
}

protocol StartViewPresenterProtocol: AnyObject {
    init(view: StartViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, insult: InsultModel, insults: InsultsModel, coredata: CoreDataManagerProtocol)
    var insult: InsultModel { get }
    var insults: InsultsModel { get }
    func getInsult()
    func tapOnSettings()
    func shareInsult(vc: UIViewController)
    func saveInsult()
}

class StartPresenter: StartViewPresenterProtocol {
    
    weak var view: StartViewProtocol?
    
    let networkService: NetworkServiceProtocol
    var coreData: CoreDataManagerProtocol
    var insult: InsultModel
    var insults: InsultsModel
    var router: RouterProtocol?
    
    required init(view: StartViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, insult: InsultModel, insults: InsultsModel, coredata: CoreDataManagerProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.insult = insult
        self.insults = insults
        self.coreData = coredata
        self.getInsult()
    }
    
    func getInsult() {
        networkService.FetchData { [weak self] insultResult, isSuccess in
            switch isSuccess {
            case true:
                self?.insult.currentInsult = insultResult
                self?.view?.success()
            case false:
                self?.view?.failure()
            }
        }
    }

    func tapOnSettings() {
        self.router?.showSettingsVC()
    }
    
    func shareInsult(vc: UIViewController) {
        let activityVC = UIActivityViewController(activityItems: ["\(self.insult.currentInsult)"], applicationActivities: nil)
               activityVC.popoverPresentationController?.sourceView = vc.view
                vc.present(activityVC, animated: true, completion: nil)
    }
    
    func saveInsult() {
        self.coreData.saveInsult(insult: self.insult.currentInsult)
    }
    
}
