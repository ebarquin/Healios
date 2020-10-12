//
//  CommentRepositoryTests.swift
//  HealiosTestTests
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import XCTest
import Alamofire
import RxSwift

@testable import HealiosTest
final class CommentRepositoryTests: XCTestCase {
    func test_fetchComment_decodesCorrect() {
        let sut = makeSUT(JSONFile: "comments")
        assertAPIResponseWithNoParamsIsNotNil(sut.fetchComments)
    }
    
    private func makeSUT(JSONFile: String) -> CommentRepositoryDefault {
        let mockAPIClient = MockApiClient(responseJSONFile: JSONFile)
        return CommentRepositoryDefault(apiClient: mockAPIClient)
    }
}

