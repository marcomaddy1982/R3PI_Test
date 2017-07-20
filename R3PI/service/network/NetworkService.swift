//
//  NetworkService.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import Foundation

let baseUrlString = "http://apilayer.net/api/"
let apiAccessKey = "6f98702338355309947d97bb4163a9c7"

enum NetworkService {

    case getCurrencyList
    case getConvert(to: String, amount: String)
    case getLiveConvert(to: String)
    
    var url: String {
        switch self {
        case .getCurrencyList():
            return baseUrlString + "list?access_key=" + apiAccessKey
        case .getConvert(let to, let amount):
            return baseUrlString + "convert?access_key=" + apiAccessKey + "&from=USD&to=" + to + "&amount=" + amount
        case .getLiveConvert(let to):
            return baseUrlString + "live?access_key=" + apiAccessKey + "&currencies=" + to
        }
    }
}
