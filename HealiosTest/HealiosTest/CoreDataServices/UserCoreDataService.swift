//
//  UserCoreDataService.swift
//  HealiosTest
//
//  Created by Eugenio on 13/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import CoreData

public final class UserCoreDataService {
    
    let context: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    init(context: NSManagedObjectContext, coreDataStack: CoreDataStack) {
      self.context = context
      self.coreDataStack = coreDataStack
    }
    
    func saveUsers(users: [User], completion: (() -> Void)?) {
        var userEntities: [UserEntity] = []
        for user in users {
            let userEntity = UserEntity(context: context)
            userEntity.id = Int16(user.id)
            userEntity.name = user.name
            userEntity.username = user.username
            userEntity.email = user.email
            userEntities.append(userEntity)
        }
        
        coreDataStack.saveContext(context) {
            if let completion = completion {
                completion()
            }
        }
    }
    
    func fetchUsersById(id: Int) -> [UserEntity] {
        let fetchRequest = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        let predicate = NSPredicate(format: "id == %@" , "\(id)")
        fetchRequest.predicate = predicate
        var userEntities: [UserEntity] = []
        do {
            userEntities = try context.fetch(fetchRequest)
        } catch {
           print("Could not fetch. \(error), \(error.localizedDescription)")
        }
        
        return userEntities
    }
}
