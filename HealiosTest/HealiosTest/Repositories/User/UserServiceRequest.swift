//
//  UserServiceRequest.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import Alamofire

enum UserServiceRequest {
    case fetchUsers
}

extension  UserServiceRequest: APIConfiguration {
    var method: HTTPMethod {
        switch self {
        case .fetchUsers:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchUsers:
            return "users"
        }
    }
    
    var parameters: Parameters? {
        return nil
    }
}

