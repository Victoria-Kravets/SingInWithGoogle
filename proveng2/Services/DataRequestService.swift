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
    
    static let shared = DataRequestService(urlScheme: APILayerConstants.ProvengURLScheme, urlHost: APILayerConstants.ProvengURLHost, urlPath: APILayerConstants.ProvengURLPath)
    
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
    
    func send(request: Request) -> Promise<Any> {
        return Promise { fulfill, reject in
            let path = request.path
            let parameters = request.parameters
            let method = request.method
            let headers = request.headers
            //let body = request.body
            var urlComponents =  URLComponents()
            urlComponents.scheme = self.urlScheme
            urlComponents.host = self.urlHost
            urlComponents.path = self.urlPath + path
            if parameters!.count > 0{
                urlComponents.query = parameters?.stringFromHttpParameters()
            }
            let urlRequest = urlComponents.url
            print(urlRequest?.absoluteString)
            let request = manager.request(urlRequest!, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { [weak self] response in
                switch response.result {
                case .success:
                    guard response.data != nil else {
                        reject(RequestError.dataError)
                        return
                    }
                    guard response.result.value != nil else {
                        reject(RequestError.dataError)
                        return
                    }
                    fulfill(response.result.value!)
                case .failure(_):
                    reject(RequestError.unsupportedError)
                }
            }
        }
    }
    
}
