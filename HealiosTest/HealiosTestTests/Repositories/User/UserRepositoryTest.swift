//
//  UserRepositoryTest.swift
//  HealiosTestTests
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import XCTest
import Alamofire
import RxSwift

@testable import HealiosTest
final class UserRepositoryTests: XCTestCase {
    func test_fetchUsers_decodesCorrect() {
        let sut = makeSUT(JSONFile: "users")
        assertAPIResponseWithNoParamsIsNotNil(sut.fetchUsers)
    }
    
    private func makeSUT(JSONFile: String) -> UserRepositoryDefault {
        let mockAPIClient = MockApiClient(responseJSONFile: JSONFile)
        return UserRepositoryDefault(apiClient: mockAPIClient)
    }
}
