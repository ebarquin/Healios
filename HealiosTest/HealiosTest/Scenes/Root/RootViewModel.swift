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
    private let disposeBag = DisposeBag()
    let posts = BehaviorRelay<[Post]>(value: [])
    let users = BehaviorRelay<[User]>(value: [])
    let comments = BehaviorRelay<[Comment]>(value: [])
    let onGettingPosts = PublishSubject<Void>()
    let onGettinUsers = PublishSubject<Void>()
    let onGettinComments = PublishSubject<Void>()
    private let loadInProgress = BehaviorRelay<Bool>(value: false)
    var onShowLoadingHud: Observable<Bool> {
        return loadInProgress
            .asObservable()
            .distinctUntilChanged()
    }
    
    init(commentRepository: CommentRepository, userRepository: UserRepository, postRepository: PostRepository, eventManager: EventManager) {
        self.commentRepository = commentRepository
        self.userRepository = userRepository
        self.postRepository = postRepository
        self.eventManager = eventManager
    }
    
    func fetchData() {
        bind()
        fetchComments()
        fetchPosts()
        fetchUsers()
    }
    
    private func fetchPosts() {
        postRepository.fetchPosts().subscribe { response in
            switch response {
            case .next(let response):
                if let response = response {
                    let posts = response.map { $0.mapped() }
                    self.posts.accept(posts)
                    self.onGettingPosts.onNext(())
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
                    self.users.accept(users)
                    self.onGettinUsers.onNext(())
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
                    self.comments.accept(comments)
                    self.onGettinComments.onNext(())
                }
            case .error:
                print("error downloading comments")
            default: break
            }
        }.disposed(by: disposeBag)
    }
    
    private func bind() {
        let observable = Observable.zip(onGettinComments, onGettingPosts, onGettinUsers)
        observable.subscribe { _ in
            self.eventManager.didGetDataFromService.onNext(())
        }.disposed(by: disposeBag)
        eventManager.didGetDataFromService.subscribe { _ in
            let data = self.composeData(posts: self.posts.value, users: self.users.value, comments: self.comments.value)
        }.disposed(by: disposeBag)
    }
    
    func composeData(posts:[Post], users:[User], comments:[Comment]) -> [Article] {
        var articles: [Article] = []
        for post in posts {
            let userId = post.userId
            let postId = post.id
            let comments = comments.filter { $0.postId == postId}
            if let user = users.filter({ $0.id == userId }).first  {
                let article = Article(post: post, user: user, comments: comments)
                articles.append(article)
            }
        }
        return articles
    }
}
