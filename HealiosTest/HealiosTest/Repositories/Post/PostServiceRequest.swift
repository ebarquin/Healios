//
//  PostServiceRequest.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import Alamofire

enum PostServiceRequest {
    case fetchPosts
}

extension  PostServiceRequest: APIConfiguration {
    var method: HTTPMethod {
        switch self {
        case .fetchPosts:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchPosts:
            return "posts"
        }
    }
    
    var parameters: Parameters? {
        return nil
    }
}
