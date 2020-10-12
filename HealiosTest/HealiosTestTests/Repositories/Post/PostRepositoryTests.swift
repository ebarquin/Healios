//
//  PostRepositoryTests.swift
//  HealiosTestTests
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import XCTest
import Alamofire
import RxSwift

@testable import HealiosTest
final class PostRepositoryTests: XCTestCase {
    func test_fetchPosts_decodesCorrect() {
        let sut = makeSUT(JSONFile: "posts")
        assertAPIResponseWithNoParamsIsNotNil(sut.fetchPosts)
    }
    
    private func makeSUT(JSONFile: String) -> PostRepositoryDefault {
        let mockAPIClient = MockApiClient(responseJSONFile: JSONFile)
        return PostRepositoryDefault(apiClient: mockAPIClient)
    }
}
