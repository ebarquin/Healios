//
//  UserEntity+Extension.swift
//  HealiosTest
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

extension UserEntity {
    
    func mapped() -> User {
        return User(id: Int(self.id),
                    name: self.name ?? "",
                    username: self.username ?? "",
                    email: self.email ?? "")
        
    }
}
