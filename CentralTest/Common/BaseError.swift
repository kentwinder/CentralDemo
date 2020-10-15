//
//  BaseError.swift
//  CentralTest
//
//  Created by Kent Winder on 10/14/20.
//

import Foundation

class BaseError: NSError {
    private let errorDomain: String = "NextzyError"
    private let errorCode: Int = 0
    
    init(message: String) {
        let userInfo = [
            "message": message
        ]
        super.init(domain: errorDomain, code: errorCode, userInfo: userInfo)
    }
    
    init(message: String, statusCode: Int) {
        let userInfo = [
            "message": message,
            "statusCode": statusCode
            ] as [String : Any]
        super.init(domain: errorDomain, code: errorCode, userInfo: userInfo)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var statusCode: Int {
        get {
            if let statusCode = self.userInfo["statusCode"] as? Int {
                return statusCode
            }
            return 0
        }
    }
    
    public var message: String {
        get {
            if let message = self.userInfo["message"] as? String {
                return message
            }
            return "Error"
        }
    }
}
