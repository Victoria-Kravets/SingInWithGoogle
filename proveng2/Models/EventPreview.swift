//
//  EventPreview.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class EventPreview: BaseModel {

    @objc dynamic var dateStart: Date? = nil
    @objc dynamic var dateEnd: Date? = nil
    @objc dynamic var regular: String? = nil
    @objc dynamic var location: Location? = nil
    @objc dynamic var type = EventType.unknown.rawValue
    @objc dynamic var createrID: Int = 0
    var typeEnum: EventType {
        get {
            return EventType(rawValue: type)
        }
    }

    override class func objectForMapping(map: Map) -> BaseMappable? {
        return EventPreview()
    }

    override func mapping(map: Map) {
        if let context = map.context as? ContextType {
            switch context {
            case .short:
                dateStart   <- (map["dateStart"], DateTransformMSeconds())
                dateEnd     <- (map["dateEnd"], DateTransformMSeconds())
                type        <- map["type"]
                regular     <- map["regular"]
                if location == nil || location?.objectID == 0 {
                } else {
                    location     <- map["location"]
                }
            case .write:
                super.mapping(map: map)

                dateStart   <- (map["dateStart"], DateTransformMSeconds())
                dateEnd     <- (map["dateEnd"], DateTransformMSeconds())
                type        <- map["type"]
                regular     <- map["regular"]
                let firstContext = map.context
                map.context = ContextType.short
                if location == nil || location?.objectID == 0 {
                } else {
                    location     <- map["location"]
                }
                map.context = firstContext
            }
        } else {
            super.mapping(map: map)
            createrID   <- map["creater.id"]
            dateStart   <- (map["dateStart"], DateTransformMSeconds())
            dateEnd     <- (map["dateEnd"], DateTransformMSeconds())
            type        <- map["type"]
            regular     <- map["regular"]
            location    <- map["location"]
        }
    }
}

extension EventPreview {
    func isPast() -> Bool {
        guard let eventDate = self.dateEnd else {
            return false
        }
        if Date().makeLocalTime() > eventDate {
            return true
        }
        return false
    }
}
