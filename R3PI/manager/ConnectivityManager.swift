//
//  ConnectivityManager.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

typealias ConnectivitySuccessBlock = () -> Void
typealias ConnectivityFailureBlock = () -> Void

private let _sharedInstance = ConnectivityManager()

class ConnectivityManager: NSObject {

    var reachability: Reachability
    
    // MARK: lifecycle
    
    override init() {
        reachability = Reachability.init()!
    }
    
    class var sharedInstance: ConnectivityManager {
        return _sharedInstance
    }
    
    // MARK: public implementation
    
    func isNetworkAvailable() -> Bool {
        return reachability.isReachable
    }
    
    func executeBlockIfConnectionIsAvailable(success: @escaping ConnectivitySuccessBlock, failure: @escaping ConnectivityFailureBlock) {
        
        if (ConnectivityManager.sharedInstance.isNetworkAvailable()){
            success()
        } else {
            failure()
        }
    }
}
