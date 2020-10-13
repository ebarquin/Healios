//
//  PostCoreDataServiceTests.swift
//  HealiosTestTests
//
//  Created by Eugenio on 13/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import XCTest
@testable import HealiosTest

class PostCoreDataServiceTests: XCTestCase {
    var postCoreDataService: PostCoreDataService!
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        postCoreDataService = PostCoreDataService(context: coreDataStack.context, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        postCoreDataService = nil
        coreDataStack = nil
    }
    
    func testGetPosts() {
        let posts = makeSut()
        let _ = postCoreDataService.savePosts(posts: posts, completion: nil)
        
        let getPosts = postCoreDataService.fetchPosts()
        XCTAssertNotNil(getPosts)
        XCTAssertTrue(getPosts.count == 2)
        XCTAssertTrue(getPosts[0].id == posts[0].id)
    }
    
    private func makeSut() -> [Post] {
        return [
            Post(userId: Int.random(in: 1...100), id: Int.random(in: 1...50), title: UUID().description, body: UUID().description),
            Post(userId: Int.random(in: 1...100), id: Int.random(in: 50...100), title: UUID().description, body: UUID().description)
        ]
    }
}
