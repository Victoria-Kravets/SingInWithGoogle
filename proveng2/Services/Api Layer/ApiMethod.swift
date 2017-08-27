//
//  ApiMethod.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import PromiseKit

/**
 Object encapsulates request parameters
 - Parameters:
 - parameters: param of request
 - path: url path of request
 - method: Alamofire.Method
 */
enum ApiMethod: Hashable {

    // MARK: User
    case getUserProfile(userID: Int)
    case updateUserProfile(user: User)
    case loginUser(gToken: String)
    case logoutUser(token: String)
    case getUsers(roleName: String)
    case getUsersCountForLevels
    case getUsersStartTest(level: String?)
    case deleteGroupUser(groupID: Int, userID: Int, note: String)
    case getUsersStatusForEvent(eventID: Int)
    // MARK: Group
    case getGroup(groupID: Int)
    case getGroups
//    case createGroup(group: Group)
//    case updateGroup(group: Group)
    case deleteGroup(groupID: Int)
    // MARK: Event
    case getEvent(eventID: Int)
    case getEvents(userID: Int)
    case getCalendar(userID: Int, date: Double)
    case getFeed(userID: Int)
//    case createEvent(event: Event)
//    case updateEvent(event: Event)
    case deleteEvent(eventID: Int)
    case acceptEvent(eventID: Int)
    case cancelEvent(eventID: Int)
//    case createVisitedEvent(eventID: Int, groupID: Int, visitedMembers: [UserPreview])
    // MARK: Schedule
    case getSchedule(groupID: Int)
//    case createSchedule(groupID: Int, schedule: [EventPreview])
//    case editSchedule(groupID: Int, schedule: [EventPreview])
    // MARK: BaseData
    case getLocations
    case getDepartments
    case getLevels
    // MARK: Test
    case getTests
    case getTest(id: Int)
//    case resultTest(test: Test, duration:Double)
    // MARK: Materials
    case getMaterials
    case getMaterial(materialID: Int)
//    case createMaterial(material: Material)
//    case editMaterial(material: Material)
    case openMaterial(materialID: Int, groupID: Int)

    var parameters: [String: AnyObject] {
        let userIDKey = "userId"
        let groupIDKey = "groupId"
        let IDKey = "id"
        let roleNameKey = "roleName"
        _ = "testId" // testIDKey
        _ = "duration"  // durationKey
        let dateKey = "date"
        switch self {
        // MARK: User
        case .getUserProfile(let userID):
            return [IDKey: userID as AnyObject]
        case .logoutUser, .getUsersCountForLevels, .loginUser, .updateUserProfile:
            return [:]
        case .getUsersStartTest(let level):
            if level != nil {
                return ["level": level as AnyObject]
            } else {
                return [:]
            }
        case .getUsers(let roleName):
            return [roleNameKey: roleName as AnyObject]
        case .deleteGroupUser(let groupID, _, _):
            return [groupIDKey: groupID as AnyObject]
        case .getUsersStatusForEvent(let eventID):
            return [IDKey: eventID as AnyObject]
        // MARK: Group
        case .getGroup(let groupID):
            return [IDKey: groupID as AnyObject]
        case .getGroups:
            return [:]
        case .deleteGroup(let groupID):
            return [IDKey: groupID as AnyObject]
        // MARK: Event
        case .getEvent(let eventID):
            return [IDKey: eventID as AnyObject]
//        case .createEvent, .updateEvent:
//            return [:]
        case .getEvents(let userID):
            return [userIDKey: userID as AnyObject]
        case .getCalendar(let userID, let date):
            return [userIDKey: userID as AnyObject, dateKey: date as AnyObject]
        case .getFeed(let userID):
            return [userIDKey: userID as AnyObject]
        case .acceptEvent(let eventID):
            return [IDKey: eventID as AnyObject]
        case .cancelEvent(let eventID):
            return [IDKey: eventID as AnyObject]
        case .deleteEvent(let eventID):
            return [IDKey: eventID as AnyObject]
//        case .createVisitedEvent(let eventID, let groupID, _):
//            return ["event_id": eventID as AnyObject, "group_id": groupID as AnyObject]
        // MARK: Schedule
        case .getSchedule(let groupID):
            return ["group_id": groupID as AnyObject]
        // MARK: BaseData
        case .getLocations, .getDepartments, .getLevels:
            return [:]
        // MARK: Test
        case .getTests:
            return [:]
        case .getTest(let id):
            return [IDKey: id as AnyObject]
//        case .resultTest(let test, let duration):
//            return [testIDKey: test.objectID as AnyObject,durationKey: duration as AnyObject]
        // MARK: Materials
        case .getMaterials:
            return [:]
        case .getMaterial(let id):
            return [IDKey: id as AnyObject]
        case .openMaterial(let materialID, let groupID):
            return ["material_id": materialID as AnyObject, "group_id": groupID as AnyObject]
        }
    }

    var path: String {
        switch self {
        // MARK: User
        case .getUserProfile, .updateUserProfile:
            return "user"
        case .loginUser:
            return "auth-by-google"
        case .logoutUser:
            return "logout"
        case .getUsers:
            return "users"
        case .getUsersCountForLevels:
            return "usersLevel"
        case .getUsersStartTest:
            return "usersStartTest"
        case .deleteGroupUser:
            return "group_users"
        case .getUsersStatusForEvent:
            return "eventUsersStatus"
        // MARK: Group
        case .getGroup:
            return "group"
        case .deleteGroup:
            return "group"
        case .getGroups:
            return "groups"
        // MARK: Event
        case .getEvent, .deleteEvent:
            return "event"
        case .getEvents:
            return "events"
        case .getCalendar:
            return "calendar"
        case .getFeed:
            return "feed"
        case .acceptEvent:
            return "eventAccepted"
        case .cancelEvent:
            return "eventDenied"
//        case .createVisitedEvent:
//            return "eventVisited"
        // MARK: Schedule
        case .getSchedule:
            return "schedule"
        // MARK: BaseData
        case .getLocations:
            return "locations"
        case .getDepartments:
            return "departments"
        case .getLevels:
            return "levels"
        // MARK: Test
        case .getTests:
            return "tests"
        case .getTest:
            return "test"
//        case .resultTest:
//            return "test_result"
        // MARK: Materials
        case .getMaterials:
            return "materials"
        case .getMaterial:
            return "material"
        case .openMaterial:
            return "openMaterial"
        }
    }
    var additionalHeaders: [String: String] {
        let tokenKey = "token"
        switch self {
        case .loginUser:
            return [:]
        default:
            return [tokenKey: SessionData.token]
        }
    }

    var body: String {
        _ = "gToken"  // tokenKey
        _ = "userId" // userIDKey
        _ = "note"  // noteKey
        return ""
    }

    var method: HTTPMethod {
        switch self {
        case .loginUser, .logoutUser, .acceptEvent, .cancelEvent, .openMaterial:
            return .post
        case .getUserProfile, .getGroup, .getGroups, .getUsers, .getUsersCountForLevels,
             .getUsersStatusForEvent, .getEvent, .getEvents, .getCalendar, .getFeed,
             .getUsersStartTest, .getSchedule, .getLocations, .getDepartments, .getLevels,
             .getTest, .getTests, .getMaterials, .getMaterial:
            return .get
        case .updateUserProfile:
            return .put
        case .deleteGroup, .deleteEvent, .deleteGroupUser:
            return .delete
        }
    }

    var hashValue: Int {
        let value = self.path + self.method.rawValue
        return value.hashValue// + address(o: &value)
    }

    func address(o: UnsafeRawPointer) -> Int {
        return Int(bitPattern: o)
    }
}

func == (lhs: ApiMethod, rhs: ApiMethod) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
