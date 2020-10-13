//
//  CoreDataStackMock.swift
//  HealiosTestTests
//
//  Created by Eugenio on 13/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import CoreData
import HealiosTest

class MockCoreDataStack: CoreDataStack {
    override init() {
        super.init()
    
    let persistentStoreDescription = NSPersistentStoreDescription()
      persistentStoreDescription.type = NSInMemoryStoreType

      let storeContainer = NSPersistentContainer(
        name: "Article")
      storeContainer.persistentStoreDescriptions = [persistentStoreDescription]

      storeContainer.loadPersistentStores { _, error in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }

      container = storeContainer
    }
}
