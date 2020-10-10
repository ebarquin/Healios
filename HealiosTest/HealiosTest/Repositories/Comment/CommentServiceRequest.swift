//
//  CommentServiceRequest.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import Alamofire

enum CommentServiceRequest {
    case fetchComments
}

extension  CommentServiceRequest: APIConfiguration {
    var method: HTTPMethod {
        switch self {
        case .fetchComments:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchComments:
            return "comments"
        }
    }
    
    var parameters: Parameters? {
        return nil
    }
}

