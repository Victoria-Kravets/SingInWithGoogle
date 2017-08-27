//
//  ServiceForRequest.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import PromiseKit

class ServiceForRequest<T: Object>: ServiceForData<T> where T: StaticMappable {

    fileprivate var apiLayer = ApiLayer.SharedApiLayer

    func deleteObjectPromise(_ keyValue: AnyObject, operation: ApiMethod) -> Promise<String> {
        return firstly {
            return self.apiLayer.requestWithDictionaryPromise(operation)
            }.then { _ in
                return self.deleteDataFromStoragePromise(keyValue)
        }
    }

}
