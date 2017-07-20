//
//  DataParser.swift
//  R3PI
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

class DataParser: NSObject {
    
    static func parserGetCurrency(dataToParse: NSData) -> ([Currency]?, R3Error?) {
        
        do {
            if let JSON = try JSONSerialization.jsonObject(with: dataToParse as Data, options: []) as? [String: AnyObject] {
                
                if let errorDict = JSON[Constant.kParserError] as? [String: AnyObject] {
                    var error = R3Error()
                    
                    if let errorCode = errorDict[Constant.kParserErrorCode] {
                        error.code = errorCode as! Int
                    }
                    
                    if let errorInfo = errorDict[Constant.kParserErrorInfo] {
                        error.info = errorInfo as! String
                    }
                    
                    return (nil, error)
                }
                
                
                if let cuncurrenciesDict = JSON[Constant.kParserCurrency] as? [String: String] {
                    var cunrrencies = [Currency]()
                    for key in cuncurrenciesDict.keys {
                        if let descr = cuncurrenciesDict[key] {
                            cunrrencies.append(Currency.init(key: key, descr: descr))
                        }
                    }
                    cunrrencies.sort(by: { $0.descr < $1.descr })
                    return (cunrrencies, nil)
                }
            }
        } catch {
            var error = R3Error()
            error.code = 101
            error.info = AlertMessages.kAlert_ServiceNotAbailable_Message
            return (nil, error)
        }
        
        var error = R3Error()
        error.code = 101
        error.info = AlertMessages.kAlert_ServiceNotAbailable_Message
        return (nil, error)
    }
    
    static func parserGetLiveConvert(dataToParse: NSData) -> (Checkout?, R3Error?) {
        
        do {
            if let JSON = try JSONSerialization.jsonObject(with: dataToParse as Data, options: []) as? [String: AnyObject] {
                
                if let errorDict = JSON[Constant.kParserError] as? [String: AnyObject] {
                    var error = R3Error()
                    
                    if let errorCode = errorDict[Constant.kParserErrorCode] {
                        error.code = errorCode as! Int
                    }
                    
                    if let errorInfo = errorDict[Constant.kParserErrorInfo] {
                        error.info = errorInfo as! String
                    }
                    
                    return (nil, error)
                }
                
                var checkout = Checkout()
                
                if let timestamp = JSON[Constant.kParserTimestamp] {
                    checkout.timestamp = TimeInterval(timestamp as! Int)
                }
                
                if let quotes = JSON[Constant.kParserQuotes] as? [String: Float] {
                    if let quote = Array(quotes.values)[0] as? Float{
                        checkout.quote = NSNumber(value: quote)
                    }
                }
                
                return (checkout, nil)
            }
        } catch {
            var error = R3Error()
            error.code = 101
            error.info = AlertMessages.kAlert_ServiceNotAbailable_Message
            return (nil, error)
        }
        
        var error = R3Error()
        error.code = 101
        error.info = AlertMessages.kAlert_ServiceNotAbailable_Message
        return (nil, error)
    }
}
