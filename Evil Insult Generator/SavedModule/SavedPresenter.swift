//
//  SavedPresenter.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 15.05.2022.
//

import Foundation
import UIKit

protocol SavedViewProtocol: AnyObject {
    
}

protocol SavedViewPresenterProtocol: AnyObject {
    init(view: SavedViewProtocol, router: RouterProtocol, insults: SavedInsultsModel, coredata: CoreDataManagerProtocol)
    var insults: SavedInsultsModel { get set }
    var index: Int { get set }
    func deleteInsult()
    func fetchInsults()
    func shareInsult(vc: UIViewController, currentInsult: String)
    func nextInsult() -> String?
    func previousInsult() -> String?
}

final class SavedPresenter: SavedViewPresenterProtocol {
    
    weak var view: SavedViewProtocol?
    var coreData: CoreDataManagerProtocol
    var router: RouterProtocol?
    var insults: SavedInsultsModel
    var index = 0
    
    required init(view: SavedViewProtocol, router: RouterProtocol, insults: SavedInsultsModel, coredata: CoreDataManagerProtocol) {
        self.view = view
        self.router = router
        self.insults = insults
        self.coreData = coredata
        self.fetchInsults()
    }
    
    func shareInsult(vc: UIViewController, currentInsult: String) {
        let activityVC = UIActivityViewController(activityItems: [currentInsult], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = vc.view
        vc.present(activityVC, animated: true, completion: nil)
    }
    
    func deleteInsult() {
        if self.index >= 0 && self.index <= self.insults.savedInsultsData.count && self.coreData.insults.savedInsultsData.isEmpty == false {
            self.coreData.deleteInsult(savedData: self.insults.savedInsultsData[self.index])
            self.fetchInsults()
            print("Сейчас в дате \(self.coreData.insults.savedInsultsData.count) ")
        }
    }
    
    func fetchInsults() {
        self.coreData.fetchInsult()
    }
    
    func nextInsult() -> String? {
        if self.index < self.insults.savedInsultsData.count - 1 {
            self.index += 1
        }
        print("индекс \(index)")
        print("Сейчас в дате \(self.coreData.insults.savedInsultsData.count) ")
        return self.insults.savedInsultsData[self.index].insult
    }
    
    func previousInsult() -> String? {
        if self.index > 0 {
            self.index -= 1
        }
        print("index \(index)")
        print("Сейчас в дате \(self.coreData.insults.savedInsultsData.count) ")
        return self.insults.savedInsultsData[self.index].insult
    }
    
}
