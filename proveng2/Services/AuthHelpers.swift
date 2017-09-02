//
//  AuthError.swift
//  proveng2
//
//  Created by Artem Misesin on 8/24/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import SystemConfiguration

struct ApiError: Error {
    
    var code = 0
    var description = "No description"
    
    init(code: Int, description: String) {
        self.code = code
        self.description = description
    }
    
    init(description: String) {
        self.description = description
    }
    
}

extension Error {
    var apiError: ApiError {
        if self is ApiError {
            return self as! ApiError // swiftlint:disable:this force_cast
        } else {
            let castedError = self as NSError
            return ApiError(code: castedError.code, description: castedError.domain)
        }
    }
}

class Connection {
    
    static var isAvailable: Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
}
