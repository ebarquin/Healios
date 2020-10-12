//
//  EventManager.swift
//  HealiosTest
//
//  Created by Eugenio on 11/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//

import RxSwift
import RxCocoa

class EventManager {
    static let shared = EventManager()
    var didGetDataFromService = PublishSubject<Void>()
    
    
}
