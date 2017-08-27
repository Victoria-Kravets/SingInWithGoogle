//
//  File.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import PromiseKit
import Realm

class BaseModel: Object, StaticMappable {

    @objc dynamic var modifyDate: Date?
    @objc dynamic var objectID: Int = 0

    class func objectForMapping(map: Map) -> BaseMappable? {
        return BaseModel()
    }

    override class func primaryKey() -> String? {
        return "objectID"
    }

    func mapping(map: Map) {
        if map.mappingType == .toJSON {
//            if self is TestCard {
//                return
//            }
            var id = self.objectID
            id <- map[primaryJSONKey]
        } else {
            self.objectID <- map[primaryJSONKey]
        }
        modifyDate     <- map["modifyDtm"]
    }

    var primaryJSONKey: String {
        return "id"
    }
}
