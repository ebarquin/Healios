//
//  FetchPostsResponse+mapper.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

extension FetchPostsResponse {
    func mapped() -> Post {
        return Post(userId: self.userId, id: self.id, title: self.title, body: self.body)
    }
}
