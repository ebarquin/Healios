//
//  APIError.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//


import Foundation

enum APIError: Error, Equatable {
    case badRequest(data: Data?)      //Status code 400
    case unauthorized           //Status code 401
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case notAcceptable          //Status code 406
    case conflict               //Status code 409
    case internalServerError    //Status code 500
}
