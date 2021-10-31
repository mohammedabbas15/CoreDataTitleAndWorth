//
//  PersistentStorage.swift
//  CoreDataTitleAndWorth
//
//  Created by Field Employee on 10/30/21.
//

import CoreData
import Foundation

class PersistentStorage {
    
    private init() {
        
    }
    
    static let shared = PersistentStorage()
    var context: NSManagedObjectContext { return persistentContainer.viewContext}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataTitleAndWorth")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
        
    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Saved successfully")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
