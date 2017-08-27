//
//  RolePermission.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class RolePermission: BaseModel {

    @objc dynamic var name: String? = nil
    @objc dynamic var hasAccessFlag: String? = nil
    @objc dynamic var object: String? = nil

    override class func objectForMapping(map: Map) -> BaseMappable? {
        return RolePermission()
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        name          <- map["name"]
        hasAccessFlag <- map["accessFlag"]
        object        <- map["object"]
    }
}
