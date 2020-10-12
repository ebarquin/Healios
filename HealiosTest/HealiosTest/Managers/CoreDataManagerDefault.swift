//
//  CoreDataManager.swift
//  HealiosTest
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import CoreData

protocol CoreDataManager {
    func saveArticle(article: Article, completion: (() -> Void)?)
    func saveArticles(articles: [Article], completion: @escaping () -> Void)
    
}

class CoreDataManagerDefault: CoreDataManager {
    
    static var shared = CoreDataManagerDefault()
    
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
    
    func saveArticle(article: Article, completion: (() -> Void)?) {
        let context = container.viewContext
        
        let postEntity = PostEntity(context: context)
        postEntity.userId = Int16(article.post.userId)
        postEntity.id = Int16(article.post.id)
        postEntity.title = article.post.title
        postEntity.body = article.post.body
        
        let userEntity = UserEntity(context: context)
        userEntity.id = Int16(article.user.id)
        userEntity.name = article.user.name
        userEntity.username = article.user.username
        userEntity.email = article.user.email
        userEntity.belongsTo = postEntity
        
        var commentEntities: [CommentEntity] = []
        
        for comment in article.comments {
            let commentEntity = CommentEntity(context: context)
            commentEntity.postId = Int16(comment.postId)
            commentEntity.id = Int16(comment.id)
            commentEntity.email = comment.email
            commentEntity.body = comment.body
            commentEntity.belongsTo = postEntity
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
    
    func saveArticles(articles: [Article], completion: @escaping () -> Void) {
        for article in articles {
            saveArticle(article: article, completion: nil)
        }
        completion()
    }
    
    func fetchPosts() -> [PostEntity] {
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<PostEntity>(entityName: "PostEntity")
        var postEntities: [PostEntity] = []
        do {
            postEntities = try context.fetch(fetchRequest)
            return postEntities
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.localizedDescription)")
        }
        
        return postEntities
    }
    
}
