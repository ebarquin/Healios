//
//  CommentRepository.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import RxSwift

protocol CommentRepository {
    func fetchComments() -> Observable<[FetchCommentsResponse]?>
}

public class CommentRepositoryDefault: CommentRepository {
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClientDefault()) {
        self.apiClient = apiClient
    }
    func fetchComments() -> Observable<[FetchCommentsResponse]?> {
        return apiClient.request(CommentServiceRequest.fetchComments)
    }
}
