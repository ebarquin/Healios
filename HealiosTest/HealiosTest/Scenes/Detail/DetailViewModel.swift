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
    let disposeBag = DisposeBag()
    let coreDataManager: CoreDataManagerDefault
    let eventManager: EventManager
    let onGettingUser = PublishSubject<User>()
    let onGettingComments = PublishSubject<[Comment]>()
    let comments = BehaviorRelay<[Comment]>(value: [])
    let user = BehaviorRelay<User?>(value: nil)
    private let loadInProgress = BehaviorRelay<Bool>(value: false)
    var onShowLoadingHud: Observable<Bool> {
        return loadInProgress
            .asObservable()
            .distinctUntilChanged()
    }
    
    init(post: Post, coreDataManager: CoreDataManagerDefault, eventManager: EventManager) {
        self.post = post
        self.coreDataManager = coreDataManager
        self.eventManager = eventManager
    }
    
    func fetchData() {
        bind()
        loadInProgress.accept(true)
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
        onGettingComments.onNext(comments)
        self.comments.accept(comments)
    }
    
    private func bind() {
        let observable = Observable.zip(onGettingUser, onGettingComments)
        observable.subscribe { _ in
            self.eventManager.didFetchDetailsData.onNext(())
        }.disposed(by: disposeBag)
        
        eventManager.didFetchDetailsData.subscribe { _ in
            self.loadInProgress.accept(false)
        }.disposed(by: disposeBag)
    }
}
