//
//  FetchCommentsResponse+mapper.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

extension FetchCommentsResponse {
    func mapped() -> Comment {
        return Comment(postId: self.postId, id: self.id, name: self.name, email: self.email, body: self.body)
    }
}
