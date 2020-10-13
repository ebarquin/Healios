//
//  UserCoreDataServiceTests.swift
//  HealiosTestTests
//
//  Created by Eugenio on 13/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import XCTest
@testable import HealiosTest

class UserCoreDataServiceTests: XCTestCase {
    var userCoreDataService: UserCoreDataService!
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        userCoreDataService = UserCoreDataService(context: coreDataStack.context, coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        userCoreDataService = nil
        coreDataStack = nil
    }
    
    func testGetUsers() {
        let users = makeSut()
        let _ = userCoreDataService.saveUsers(users: users, completion: nil)
        let id = users[0].id
        let getUsers = userCoreDataService.fetchUsersById(id: id)
        XCTAssertNotNil(getUsers)
    }
    
    private func makeSut() -> [User] {
        return [
            User(id: Int.random(in: 1...1000), name: UUID().description, username: UUID().description, email: UUID().description),
            User(id: Int.random(in: 1...1000), name: UUID().description, username: UUID().description, email: UUID().description)
        ]
    }
}
