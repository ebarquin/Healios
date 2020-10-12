//
//  JSONDecoder+Extension.swift
//  HealiosTestTests
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func fromFile<T: Decodable>(filename: String) -> T? {
        let bundle = Bundle(for: MockApiClient.self)
        
        if let url = bundle.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
