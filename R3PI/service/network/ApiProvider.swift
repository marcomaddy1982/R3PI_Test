//
//  ApiProvider.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import Foundation

typealias NetworkServiceCompletitionhandler = (Data?, URLResponse?, Error?) -> Void

class ApiProvider {
    
    var service: NetworkService
    
    required init(service: NetworkService) {
        self.service = service
    }
    
    func start(completionHandler: @escaping NetworkServiceCompletitionhandler) {
        if let url = URL(string: self.service.url){
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: url, completionHandler: completionHandler)
            task.resume()
        }
    }
}
