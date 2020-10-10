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
    private let disposeBag = DisposeBag()
    private let loadInProgress = BehaviorRelay<Bool>(value: false)
    var onShowLoadingHud: Observable<Bool> {
        return loadInProgress
            .asObservable()
            .distinctUntilChanged()
    }
    
    init(commentRepository: CommentRepository, userRepository: UserRepository, postRepository: PostRepository) {
        self.commentRepository = commentRepository
        self.userRepository = userRepository
        self.postRepository = postRepository
    }
    
    func fetchData() {
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
                    //TODO PERSIST IN CORE DATA
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
                    //TODO PERSIST IN CORE DATA
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
                    let comment = response.map { $0.mapped() }
                    //TODO PERSIST IN CORE DATA
                }
            case .error:
                print("error downloading comments")
            default: break
            }
        }.disposed(by: disposeBag)
    }
}
