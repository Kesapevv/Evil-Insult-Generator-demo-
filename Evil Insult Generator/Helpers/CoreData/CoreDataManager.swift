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
    init(insults: InsultsModel)
    var insults: InsultsModel { get set }
    func saveInsult(insult: String)
    func fetchInsult()
    func deleteInsult(savedData: NSManagedObject)
}

class CoreDataManager: CoreDataManagerProtocol {
    
    var insults: InsultsModel
    
    required init(insults: InsultsModel) {
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


////    func deleteInsult() {
//func deleteInsult() {
//    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//
//    let context = appDelegate.persistentContainer.viewContext
//    let fetchRequest: NSFetchRequest<Insults> = Insults.fetchRequest()
//
//    if case self.insults.savedInsultsData = try? context.fetch(fetchRequest) {
////            for insult in self.insults.savedInsults {
////                context.delete(insult)
////            }
//        context.delete(self.insults.savedInsultsData.last!)
//
//        do {
//            try context.save()
//            print(self.insults.savedInsultsData.count)
//            print("\(String(describing: self.insults.savedInsultsData.first))")
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//}
