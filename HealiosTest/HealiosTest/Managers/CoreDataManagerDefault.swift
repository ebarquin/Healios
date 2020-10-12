//
//  CoreDataManager.swift
//  HealiosTest
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import CoreData
import RxSwift

protocol CoreDataManager {
    func fetchPosts() -> [PostEntity]
    func fetchUsersById(id: Int) -> [UserEntity]
    
}

class CoreDataManagerDefault: CoreDataManager {
    
    static var shared = CoreDataManagerDefault()
    let onPersistingPosts = PublishSubject<Void>()
    let onPersitingUsers = PublishSubject<Void>()
    let onPersitingComments = PublishSubject<Void>()
    
    private var container: NSPersistentContainer!
    
    func setupDataBase() {
        container = NSPersistentContainer(name: "Article")
        container.loadPersistentStores { (desc, error) in
            if let error = error {
                print("Error loading stores \(desc) - \(error)")
                return
            }
            
            print("Database ready!")
        }
    }
    
    
    func savePosts(posts: [Post], completion: (() -> Void)?) {
        let context = container.viewContext
        var postEntities: [PostEntity] = []
        for post in posts {
            let postEntity = PostEntity(context: context)
            postEntity.userId = Int16(post.userId)
            postEntity.id = Int16(post.id)
            postEntity.title = post.title
            postEntity.body = post.body
            postEntities.append(postEntity)
        }
        
        do {
            try context.save()
            context.reset()
            DispatchQueue.main.async {
                if let completion = completion {
                    completion()
                }
            }
        } catch {
            print("Error saving data")
        }
    }
    
    func saveUsers(users: [User], completion: (() -> Void)?) {
        let context = container.viewContext
        var userEntities: [UserEntity] = []
        for user in users {
            let userEntity = UserEntity(context: context)
            userEntity.id = Int16(user.id)
            userEntity.name = user.name
            userEntity.username = user.username
            userEntity.email = user.email
            userEntities.append(userEntity)
        }
        
        do {
            try context.save()
            context.reset()
            DispatchQueue.main.async {
                if let completion = completion {
                    completion()
                }
            }
        } catch {
            print("Error saving data")
        }
    }
    
    func saveComments(comments: [Comment],completion: (() -> Void)?) {
        let context = container.viewContext
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
        
        do {
            try context.save()
            context.reset()
            DispatchQueue.main.async {
                if let completion = completion {
                    completion()
                }
            }
        } catch {
            print("Error saving data")
        }
    }

    func fetchPosts() -> [PostEntity] {
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<PostEntity>(entityName: "PostEntity")
        var postEntities: [PostEntity] = []
        do {
            postEntities = try context.fetch(fetchRequest)

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.localizedDescription)")
        }

        return postEntities
    }
    
    func fetchUsersById(id: Int) -> [UserEntity] {
        let context = container.viewContext
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
    
    func fetchCommentsById(id: Int) -> [CommentEntity] {
        let context = container.viewContext
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
    
    func deleteAll() {
        let context = container.viewContext
        let postsFetchRequest = NSFetchRequest<PostEntity>(entityName: "PostEntity")
        let usersFetchRequest = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        let comentsFetchRequest = NSFetchRequest<CommentEntity>(entityName: "CommentEntity")
        
        do {
            let posts = try context.fetch(postsFetchRequest)
            let users = try context.fetch(usersFetchRequest)
            let comments = try context.fetch(comentsFetchRequest)

            for post in posts {
                context.delete(post)
            }
            for user in users {
                context.delete(user)
            }
            for comment in comments {
                context.delete(comment)
            }
            
            try context.save()

        } catch {
            // Error Handling
            // ...
        }
        
    }
    
}
