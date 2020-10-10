//
//  FetchUserResponse+mapper.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

extension FetchUsersResponse {
    func mapped() -> User {
        return User(id: self.id, name: self.name, username: self.username, email: self.email)
    }
}
