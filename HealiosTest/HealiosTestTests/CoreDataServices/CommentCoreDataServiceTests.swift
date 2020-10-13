//
//  CommentCoreDataServiceTests.swift
//  HealiosTestTests
//
//  Created by Eugenio on 13/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//


import XCTest
@testable import HealiosTest

class CommentCoreDataServiceTests: XCTestCase {
    var commentCoreDataService: CommentCoreDataService!
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        commentCoreDataService = CommentCoreDataService(context: coreDataStack.context, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        commentCoreDataService = nil
        coreDataStack = nil
    }
    
    func testGetComments() {
        let comments = makeSut()
        let _ = commentCoreDataService.saveComments(comments: comments, completion: nil)
        let id = comments[0].postId
        let getComments = commentCoreDataService.fetchCommentsById(id: id)
        XCTAssertNotNil(getComments)
    }
    
    private func makeSut() -> [Comment] {
        return [
            Comment(postId: Int.random(in: 1...1000), id: Int.random(in: 1...1000), name: UUID().description, email: UUID().description, body: UUID().description)
        ]
    }
}
