//
//  OnResult.swift
//  HealiosTest
//
//  Created by Eugenio on 10/10/2020.
//  Copyright © 2020 Eugenio Barquín. All rights reserved.
//


enum OnResult<Value> {
    case success(Value)
    case error
}
