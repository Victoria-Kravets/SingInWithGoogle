//
//  MapperPromise.swift
//  proveng2
//
//  Created by Viktoria on 8/23/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import ObjectMapper
import PromiseKit
import RealmSwift

class MapperPromise<T: Object> where T: StaticMappable {
    func mapFromJSONPromise(json: [String: Any]) -> Promise<T> {
        return Promise { fulfill, reject in
            guard let object = Mapper<T>().map(JSON: json) else {
                let error = ApiError(errorDescription: "Error in mapFromJSONPromise")
                reject(error)
                return
            }
            fulfill(object)
        }
    }
    func mapToJsonPromise(data: T) -> Promise<[String: Any]> {
        return Promise { fulfill, _ in
            guard let realm = try? Realm() else {
                fatalError("Cannot init Realm")
            }
            try realm.write {
                let json = Mapper<T>().toJSON(data)
                fulfill(json)
            }
        }
    }
}
