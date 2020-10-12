//
//  DetailViewModel.swift
//  HealiosTest
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import RxSwift
import RxCocoa

class DetailViewModel {
    let post: Post
    let coreDataManager: CoreDataManagerDefault
    let onGettingUser = PublishSubject<User>()
    let onGettingComments = PublishSubject<[Comment]>()
    let comments = BehaviorRelay<[Comment]>(value: [])
    let user = BehaviorRelay<User?>(value: nil)
    
    init(post: Post, coreDataManager: CoreDataManagerDefault) {
        self.post = post
        self.coreDataManager = coreDataManager
    }
    
    func fetchData() {
        fetchUser()
        fetchComments()
    }
    
    private func fetchUser() {
        let id = post.userId
        let userEntity = coreDataManager.fetchUsersById(id: id).first
        guard let user = userEntity?.mapped() else { return }
        onGettingUser.onNext(user)
    }
    
    private func fetchComments() {
        let id = post.id
        let commentEntities = coreDataManager.fetchCommentsById(id: id)
        let comments = commentEntities.map { $0.mapped() }
        self.comments.accept(comments)
//        onGettingComments.onNext(comments)
    }
}
