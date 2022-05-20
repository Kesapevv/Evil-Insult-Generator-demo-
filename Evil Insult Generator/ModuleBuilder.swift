//
//  ModuleBuilder.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 12.05.2022.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func createStartModule(router: RouterProtocol) -> UIViewController
    func createSettingsModule(router: RouterProtocol) -> UIViewController
    func createSavedModule(router: RouterProtocol) -> UIViewController
}

class AssemblyModelBuilder: AssemblyBuilderProtocol {
    
    func createStartModule(router: RouterProtocol) -> UIViewController {
        let view = InsultVC()
        let insult = InsultModel()
        let insults = InsultsModel()
        let networkService = Network()
        let coreData = CoreDataManager(insults: insults)
        let presenter = StartPresenter(view: view, networkService: networkService, router: router, insult: insult, insults: insults, coredata: coreData)
        view.presenter = presenter
        return view
    }
    
    func createSettingsModule(router: RouterProtocol) -> UIViewController {
        let view = SettingsVC()
        let presenter = SettingsPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createSavedModule(router: RouterProtocol) -> UIViewController {
        let view = SavedInsultsVC()
        let insults = InsultsModel()
        let coreData = CoreDataManager(insults: insults)
        let presenter = SavedPresenter(view: view, router: router, insults: insults, coredata: coreData)
        view.presenter = presenter
        return view
    }
    
}
