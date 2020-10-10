//
//  APIClient.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//


import Alamofire
import RxSwift

protocol APIClient {
    func request<T: Decodable> (_ urlConvertible: URLRequestConvertible) -> Observable<T?>
}

class APIClientDefault: APIClient {
    @discardableResult
    func request<T: Decodable> (_ urlConvertible: URLRequestConvertible) -> Observable<T?> {
        return Observable<T?>.create { observer in
            let request = AF.request(urlConvertible)
                .validate(statusCode: 200..<300)
                .responseDecodable { (response: DataResponse<T, AFError>) in
                    print(response.debugDescription)
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        switch response.response?.statusCode {
                        case 400:
                            observer.onError((APIError.badRequest(data: response.data)))
                        case 401:
                            observer.onError(APIError.unauthorized)
                        case 403:
                            observer.onError(APIError.forbidden)
                        case 404:
                            observer.onError(APIError.notFound)
                        case 406:
                            observer.onError(APIError.notAcceptable)
                        case 409:
                            observer.onError(APIError.conflict)
                        case 500:
                            observer.onError(APIError.internalServerError)
                        case 204:
                            observer.onNext(nil)
                        default:
                            observer.onError(error)
                        }
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
