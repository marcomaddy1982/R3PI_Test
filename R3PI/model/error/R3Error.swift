//
//  Error.swift
//  R3PI
//
//  Created by Marco Maddalena on 18/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//
import UIKit

struct R3Error {

    var code: Int = 0
    var info: String = ""
    
    func isValid() -> Bool {
        if self.code != 0 {
            return true
        }
        return false
    }
}
