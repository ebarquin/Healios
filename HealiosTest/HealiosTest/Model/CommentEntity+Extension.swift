//
//  CommentEntity+Extension.swift
//  HealiosTest
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

extension CommentEntity {
    
    func mapped() -> Comment {
        return Comment(postId: Int(self.postId),
                       id: Int(self.id),
                       name: self.name ?? "",
                       email: self.email ?? "",
                       body: self.body ?? "")
    }
}
