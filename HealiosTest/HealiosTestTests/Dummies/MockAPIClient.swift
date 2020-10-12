//
//  MockAPIServiceManager.swift
//  HealiosTestTests
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import Alamofire
import RxSwift
@testable import HealiosTest

class MockApiClient: APIClient {
    
    private let responseJSONFile: String
    
    init(responseJSONFile: String) {
        
        self.responseJSONFile = responseJSONFile
    }
    
    func request<T: Decodable> (_ urlConvertible: URLRequestConvertible) -> Observable<T?> {
        return Observable<T?>.create { observer in
            let value: T? = JSONDecoder().fromFile(filename: self.responseJSONFile)
            observer.onNext(value)
            
            return Disposables.create()
        }
    }
}
