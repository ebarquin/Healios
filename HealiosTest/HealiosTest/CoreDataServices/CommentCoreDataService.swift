//
//  CommentCoreDataService.swift
//  HealiosTest
//
//  Created by Eugenio on 13/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import CoreData

public final class CommentCoreDataService {
    
    let context: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    init(context: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.context = context
        self.coreDataStack = coreDataStack
    }
    
    func saveComments(comments: [Comment],completion: (() -> Void)?) {
        var commentEntities: [CommentEntity] = []
        for comment in comments {
            let commentEntity = CommentEntity(context: context)
            commentEntity.postId = Int16(comment.postId)
            commentEntity.id = Int16(comment.id)
            commentEntity.email = comment.email
            commentEntity.body = comment.body
            commentEntity.name = comment.name
            commentEntities.append(commentEntity)
        }
        
        coreDataStack.saveContext(context) {
            if let completion = completion {
                completion()
            }
        }
    }
    
    func fetchCommentsById(id: Int) -> [CommentEntity] {
        let fetchRequest = NSFetchRequest<CommentEntity>(entityName: "CommentEntity")
        let predicate = NSPredicate(format: "postId == %@" , "\(id)")
        fetchRequest.predicate = predicate
        var commentEntities: [CommentEntity] = []
        do {
            commentEntities = try context.fetch(fetchRequest)
        } catch {
            print("Could not fetch. \(error), \(error.localizedDescription)")
        }
        
        return commentEntities
    }
}
