//
//  CoreDataManager.swift
//  HealiosTest
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import CoreData
import RxSwift

open class CoreDataStack {
    
    public lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Article")
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Error loading stores \(desc) - \(error)")
                fatalError()
            }
        }
        return container
    }()
    
    public lazy var context: NSManagedObjectContext = {
        return container.viewContext
    }()
    
    public init() {
    }
    
    
    func saveContext(_ context: NSManagedObjectContext, completion: (() -> Void)? ) {
        do {
            try context.save()
            context.reset()
            DispatchQueue.main.async {
                if let completion = completion {
                    completion()
                }
            }
        } catch {
            fatalError()
        }
    }
}
