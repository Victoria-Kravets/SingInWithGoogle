//
//  GroupLevelPreview.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class GroupLevelPreview: BaseModel{

    @objc dynamic var name: String? = nil
    @objc dynamic var value: Int = 0

    override class func objectForMapping(map: Map) -> BaseMappable? {
        return GroupLevelPreview()
    }
    override class func primaryKey() -> String? {
        return "name"
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        name    <- map["name"]
        value   <- map["value"]
    }
}

