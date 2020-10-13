//
//  PostCoreDataService.swift
//  HealiosTest
//
//  Created by Eugenio on 13/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import CoreData

public final class PostCoreDataService {
    
    let context: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    init(context: NSManagedObjectContext, coreDataStack: CoreDataStack) {
      self.context = context
      self.coreDataStack = coreDataStack
    }
    
    public func savePosts(posts: [Post], completion: (() -> Void)?) {
        var postEntities: [PostEntity] = []
        for post in posts {
            let postEntity = PostEntity(context: context)
            postEntity.userId = Int16(post.userId)
            postEntity.id = Int16(post.id)
            postEntity.title = post.title
            postEntity.body = post.body
            postEntities.append(postEntity)
        }
        
        coreDataStack.saveContext(context) {
            if let completion = completion {
                completion()
            }
        }
    }
    
    public func fetchPosts() -> [PostEntity] {
        let fetchRequest = NSFetchRequest<PostEntity>(entityName: "PostEntity")
        var postEntities: [PostEntity] = []
        let idSort = NSSortDescriptor(key:"id", ascending:true)
        fetchRequest.sortDescriptors = [idSort]
        do {
            postEntities = try context.fetch(fetchRequest)

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.localizedDescription)")
        }

        return postEntities
    }
}
