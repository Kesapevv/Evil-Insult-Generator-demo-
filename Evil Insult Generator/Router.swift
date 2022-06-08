//
//  Router.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 13.05.2022.
//

import Foundation
import UIKit

protocol RouterMain {
    var navigationContoller: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewContoller()
    func showSettingsVC()
    func showSavedInsults()
    func popToRoot()
}

final class Router: RouterProtocol {
    
    var navigationContoller: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationContoller: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationContoller = navigationContoller
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewContoller() {
        if let navigationContoller = navigationContoller {
            guard let mainViewController = assemblyBuilder?.createStartModule(router: self) else { return }
            navigationContoller.viewControllers = [mainViewController]
        }
    }
    
    func showSettingsVC() {
        if let navigationContoller = navigationContoller {
            guard let settingsViewController = assemblyBuilder?.createSettingsModule(router: self) else { return }
            navigationContoller.pushViewController(settingsViewController, animated: true)
        }
    }
    
    func showSavedInsults() {
        if let navigationContoller = navigationContoller {
            guard let savedInsultsViewContoller = assemblyBuilder?.createSavedModule(router: self) else { return }
            navigationContoller.pushViewController(savedInsultsViewContoller, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationContoller = navigationContoller {
            navigationContoller.popToRootViewController(animated: true)
        }
    }

}
