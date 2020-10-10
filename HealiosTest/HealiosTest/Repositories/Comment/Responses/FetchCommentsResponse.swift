//
//  FetchCommentsResponse.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

struct FetchCommentsResponse: Codable {
    let postId: Int
    let id: Int
    let email: String
    let body: String
}
