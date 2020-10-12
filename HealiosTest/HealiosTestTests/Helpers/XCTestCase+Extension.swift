//
//  XCTestCase+Extension.swift
//  HealiosTestTests
//
//  Created by Eugenio on 12/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//


import XCTest
import Alamofire
import RxSwift

extension XCTestCase {
    
    func assertAPIResponseWithNoParamsIsNotNil<R>(_ repositoryCall: () -> Observable<R?>, file: StaticString = #file, line: UInt = #line) {
           let expectation = XCTestExpectation(description: "Recieve API client response")
           
           let disposeBag = DisposeBag()
           
           repositoryCall()
               .subscribe { response in
                   switch response {
                   case .next(let value):
                       XCTAssertNotNil(value, "Couldn't decode JSON", file: file, line: line)
                   default:
                       XCTFail("Unknown error", file: file, line: line)
                   }
                   expectation.fulfill() }
               .disposed(by: disposeBag)
           
           wait(for: [expectation], timeout: 5)
       }
}
