//
//  ServiceForData.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import PromiseKit

class ServiceForData<T: Object> where T:StaticMappable {

    func deleteTablesAfterLogoutPromise() -> Promise<String> {
        return Promise { fulfill, _ in
            let realm = try Realm()
            try realm.write {
//                realm.delete(realm.objects(EventPreview.self))
//                realm.delete(realm.objects(Event.self))
//                realm.delete(realm.objects(FeedEvent.self))
//                realm.delete(realm.objects(GroupPreview.self))
//                realm.delete(realm.objects(MaterialPreview.self))
//                realm.delete(realm.objects(TestPreview.self))
                realm.delete(realm.objects(Session.self))
                fulfill("Success")
            }
            }.recover { error -> String in
                throw error.apiError
        }
    }

    func deleteDataFromStoragePromise(_ keyValue: AnyObject) -> Promise<String> {
        return Promise { fulfill, reject in
            let realm = try Realm()
            let objectToDelete = realm.object(ofType: T.self, forPrimaryKey: keyValue)
            try realm.write {
                guard objectToDelete != nil else {
                    return reject(ApiError(errorDescription:"No objects for delete \(T()) \(keyValue)") as NSError)
                }
                realm.delete(objectToDelete!)
                fulfill("Success")
            }
            }.recover { error -> String in
                throw error.apiError
        }
    }
}
