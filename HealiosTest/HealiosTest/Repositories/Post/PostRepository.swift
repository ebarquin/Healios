//
//  PostRepository.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import RxSwift

protocol PostRepository {
    func fetchPosts() -> Observable<[FetchPostsResponse]?>
}

public class PostRepositoryDefault: PostRepository {
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClientDefault()) {
        self.apiClient = apiClient
    }
    func fetchPosts() -> Observable<[FetchPostsResponse]?> {
        return apiClient.request(PostServiceRequest.fetchPosts)
    }
}
