//
//  CoreDataManager.swift
//  Evil Insult Generator
//
//  Created by Vadim Voronkov on 15.05.2022.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataManagerProtocol {
    init(insults: SavedInsultsModel)
    var insults: SavedInsultsModel { get set }
    func saveInsult(insult: String)
    func fetchInsult()
    func deleteInsult(savedData: NSManagedObject)
}

class CoreDataManager: CoreDataManagerProtocol {
    
    var insults: SavedInsultsModel
    
    required init(insults: SavedInsultsModel) {
        self.insults = insults
    }
    
    func saveInsult(insult: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Insults", in: context) else { return }
        
        let insultObject = Insults(entity: entity, insertInto: context)
        insultObject.insult = insult
        
        do {
            try context.save()
            self.insults.savedInsultsData.append(insultObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func fetchInsult() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Insults> = Insults.fetchRequest()
        
        do {
            self.insults.savedInsultsData = try context.fetch(fetchRequest)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteInsult(savedData: NSManagedObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Insults> = Insults.fetchRequest()
        
        do {
            self.insults.savedInsultsData = try context.fetch(fetchRequest)
            context.delete(savedData)
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
