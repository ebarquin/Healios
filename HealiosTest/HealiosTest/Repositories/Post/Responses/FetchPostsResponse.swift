//
//  FetchPostsResponse.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

struct FetchPostsResponse: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
