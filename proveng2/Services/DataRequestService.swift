//
//  DataRequestService.swift
//  proveng2
//
//  Created by Artem Misesin on 8/26/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

struct  APILayerConstants {
    static let ProvengURLHost = "proveng.cloud.provectus-it.com"
    static let ProvengURLScheme = "http"
    static let ProvengURLPath = "/rest/v1/"
    static let ResultKey = "result"
    static let ErrorKey = "error"
    static let ErrorTypeKey = "type"
    static let ErrorCodeKey = "code"
    static let ErrorDescriptionKey = "description"
}

class DataRequestService {
    
    static let shared = DataRequestService(urlScheme: APILayer.ProvengURLScheme, urlHost: APILayerConstants.ProvengURLHost, urlPath: APILayerConstants.ProvengURLPath)
    
    let urlScheme: String
    let urlHost: String
    let urlPath: String
    let manager: Alamofire.SessionManager
    
    init(urlScheme: String, urlHost: String, urlPath: String){
        self.urlHost = urlHost
        self.urlScheme = urlScheme
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        self.manager = Alamofire.SessionManager(configuration: configuration)
        self.urlPath = urlPath
    }
    
}
