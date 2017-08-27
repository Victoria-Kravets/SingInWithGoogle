//
//  Location.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Location: BaseModel {

    @objc dynamic var name: String? = nil
    @objc dynamic var place: String? = nil
    @objc dynamic var roominess: String? = nil

    override class func objectForMapping(map: Map) -> BaseMappable? {
        return Location()
    }

    override func mapping(map: Map) {
        if let context = map.context as? ContextType{
            switch context {
            case .short:
                var id = self.objectID
                id <- map["id"]
            default:
                super.mapping(map: map)
                name       <- map["name"]
                place      <- map["place"]
                roominess  <- map["roominess"]
            }
        } else {
            super.mapping(map: map)
            name   <- map["name"]
            place      <- map["place"]
            roominess  <- map["roominess"]
        }
    }
}
