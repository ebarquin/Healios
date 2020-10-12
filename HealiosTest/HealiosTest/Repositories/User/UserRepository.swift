//
//  UserRepository.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import RxSwift

protocol UserRepository {
    func fetchUsers() -> Observable<[FetchUsersResponse]?>
}

public class UserRepositoryDefault: UserRepository {
    private let apiClient: APIClient
    
    init(apiClient: APIClient = APIClientDefault()) {
        self.apiClient = apiClient
    }
    func fetchUsers() -> Observable<[FetchUsersResponse]?> {
        return apiClient.request(UserServiceRequest.fetchUsers)
    }
}
