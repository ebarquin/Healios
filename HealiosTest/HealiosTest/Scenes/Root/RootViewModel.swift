//
//  RootViewModel.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import RxSwift
import RxCocoa

class RootViewModel {
    
    private let commentRepository: CommentRepository
    private let userRepository: UserRepository
    private let postRepository: PostRepository
    private let eventManager: EventManager
    private let coreDataManager: CoreDataManagerDefault
    private let disposeBag = DisposeBag()
    let coreDataPosts = BehaviorRelay<[Post]>(value:[])
    let didPersistPosts = PublishSubject<Void>()
    let didPersistUsers = PublishSubject<Void>()
    let didPersistComments = PublishSubject<Void>()
    private let loadInProgress = BehaviorRelay<Bool>(value: false)
    var onShowLoadingHud: Observable<Bool> {
        return loadInProgress
            .asObservable()
            .distinctUntilChanged()
    }
    
    init(commentRepository: CommentRepository, userRepository: UserRepository, postRepository: PostRepository, eventManager: EventManager, coreDataManager: CoreDataManagerDefault) {
        self.commentRepository = commentRepository
        self.userRepository = userRepository
        self.postRepository = postRepository
        self.eventManager = eventManager
        self.coreDataManager = coreDataManager
    }
    
    func fetchData() {
        bind()
        loadInProgress.accept(true)
        let status = UserDefaults.standard.bool(forKey: Constants.IS_DOWNLOAD)
        if status {
            getPostsFromCoreDataToDomain()
        } else {
            fetchComments()
            fetchPosts()
            fetchUsers()
        }
    }
    
    private func fetchPosts() {
        postRepository.fetchPosts().subscribe { response in
            switch response {
            case .next(let response):
                if let response = response {
                    let posts = response.map { $0.mapped() }
                    self.coreDataManager.savePosts(posts: posts) {
                        self.didPersistPosts.onNext(())
                    }
                }
            case .error:
                print("error downloading posts")
            default: break
            }
        }.disposed(by: disposeBag)
    }
    
    private func fetchUsers() {
        userRepository.fetchUsers().subscribe { response in
            switch response {
            case .next(let response):
                if let response = response {
                    let users = response.map { $0.mapped() }
                    self.coreDataManager.saveUsers(users: users) {
                        self.didPersistUsers.onNext(())
                    }
                }
            case .error:
                print("error downloading users")
            default: break
            }
        }.disposed(by: disposeBag)
    }
    
    private func fetchComments() {
        commentRepository.fetchComments().subscribe { response in
            switch response {
            case .next(let response):
                if let response = response {
                    let comments = response.map { $0.mapped() }
                    self.coreDataManager.saveComments(comments: comments) {
                        self.didPersistComments.onNext(())
                    }
                }
            case .error:
                print("error downloading comments")
            default: break
            }
        }.disposed(by: disposeBag)
    }
    
    private func bind() {
        let observable = Observable.zip(didPersistComments, didPersistPosts, didPersistUsers)
        observable.subscribe { _ in
            self.eventManager.didPersistData.onNext(())
        }.disposed(by: disposeBag)
        eventManager.didPersistData.subscribe { _ in
            UserDefaults.standard.set(true, forKey: Constants.IS_DOWNLOAD )
            self.getPostsFromCoreDataToDomain()
        }.disposed(by: disposeBag)
    }
    
    private func getPostsFromCoreDataToDomain() {
        let posts = coreDataManager.fetchPosts().map {$0.mapped() }
        coreDataPosts.accept(posts)
        loadInProgress.accept(false)
    }
}
