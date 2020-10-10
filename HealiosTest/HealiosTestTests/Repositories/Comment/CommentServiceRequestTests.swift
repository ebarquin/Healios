//
//  CommentServiceRequestTests.swift
//  HealiosTestTests
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import XCTest
import Alamofire

@testable import HealiosTest

class CommentServiceRequestTests: XCTestCase {
    
    func test_request_ReturnedGetMethod() {
        let sut = makeSUT()
        XCTAssertEqual(HTTPMethod.get, sut.method)
    }
    
     func test_request_ReturnsCorrectPath() {
    
        let sut = makeSUT()
        XCTAssertEqual(sut.path, "comments")
    }
    
    func test_request_ReturnNoParameters() {
        let sut = makeSUT()
        XCTAssertNil(sut.parameters)
    }

    private func makeSUT() -> CommentServiceRequest {
        return CommentServiceRequest.fetchComments
    }
}
