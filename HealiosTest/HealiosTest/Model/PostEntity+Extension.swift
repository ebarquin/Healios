//
//  PostEntity+Extension.swift
//  HealiosTest
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

extension PostEntity {
    
    func mapped() -> Post {
        return Post(userId: Int(self.userId),
                    id: Int(self.id),
                    title: self.title ?? "",
                    body: self.body ?? "")
    }
}
