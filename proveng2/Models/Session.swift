//
//  Session.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Session: BaseModel {

    @objc dynamic var userID: Int = 0
    @objc dynamic var token: String?
    @objc dynamic var currentUser: User?

    override class func objectForMapping(map: Map) -> BaseMappable? {
        return Session()
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        token     <- map["token"]
        userID    <- map["userId"]
        objectID = userID
    }
}
