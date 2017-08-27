//
//  User.swift
//  proveng2
//
//  Created by Viktoria on 8/22/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class User: BaseModel {
    @objc dynamic var loginName: String?
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    @objc dynamic var imageURL: String?
    @objc dynamic var email: String?
    @objc dynamic var userID: Int = 0
    var role = List<Role>()
    override static func objectForMapping(map: Map) -> BaseMappable? {
        return User()
    }
    override func mapping(map: Map) {
        var id = self.userID
        id             <- map[primaryJSONKey]
        loginName      <- map["loginName"]
        firstName      <- map["firstName"]
        lastName       <- map["lastName"]
        imageURL       <- map["imageURL"]
        email          <- map["email"]
    }
    override class func primaryKey() -> String? {
        return "userID"
    }
}
extension User {
    func userIsTeacher() -> Bool {
        let teacherRole = self.role.filter{ $0.name == "Teacher" }
        let adminRole = self.role.filter{ $0.name == "Administrator" }
        return (teacherRole.count > 0 || adminRole.count > 0) ? true : false
    }
}

enum UserRoleType: String {
    case guest = "Guest"
    case student = "Student"
    case teacher = "Teacher"
}
