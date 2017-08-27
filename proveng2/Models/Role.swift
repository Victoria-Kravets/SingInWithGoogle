//
//  Role.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Role: BaseModel {

    @objc dynamic var name: String? = nil
    var permissions = List<RolePermission>()

    class func newInstance(_ map: Map) -> BaseMappable? {
        return Role()
    }

    override class func objectForMapping(map: Map) -> BaseMappable? {
        return Role()
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        name          <- map["name"]
        permissions   <- (map["permissions"], ArrayTransform<RolePermission>())
    }
}
