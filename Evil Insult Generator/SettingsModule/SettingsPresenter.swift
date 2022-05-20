//
//  SettingsPresenter.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 13.05.2022.
//

import Foundation
import UIKit
import StoreKit

protocol SettingsViewProtocol: AnyObject {
    func isNotification() -> Bool
}

protocol SettingsViewPresenterProtocol: AnyObject {
    init(view: SettingsViewProtocol, router: RouterProtocol)
    func popToVC()
    func pushSavedVC()
    func rateUsAction(vc: UIViewController)
}

class SettingsPresenter: SettingsViewPresenterProtocol {
    
    weak var view: SettingsViewProtocol?
    var router: RouterProtocol?
    
    required init(view: SettingsViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func isNotification() -> Bool {
        return true
    }
    
    func popToVC() {
        self.router?.popToRoot()
    }
    
    func pushSavedVC() {
        self.router?.showSavedInsults()
    }
    
    func rateUsAction(vc: UIViewController) {
        guard let scene = vc.view?.window?.windowScene else {
            print("no scene")
            return
        }
        SKStoreReviewController.requestReview(in: scene)
    }
    
}

