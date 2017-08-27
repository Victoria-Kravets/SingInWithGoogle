//
//  EventTypes.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import UIKit


@objc public enum EventType: Int {
    case workshop
    case lesson
    case material
    case test
    case cancelled
    case accepted
    case unknown

    public var rawValue: String {
        switch self {
        case .workshop:
            return "Workshop"
        case .lesson:
            return "Lesson"
        case .material:
            return "Material"
        case .test:
            return "Test"
        case .accepted:
            return "Accepted"
        case .cancelled:
            return "Denied"
        case .unknown:
            return "Unknown"
        }
    }

    public init(rawValue: String) {
        switch rawValue {
        case "Workshop":
            self = .workshop
        case "Lesson":
            self = .lesson
        case "Material":
            self = .material
        case "Test":
            self = .test
        case "Accepted":
            self = .accepted
        case "Denied":
            self = .cancelled
        case "Unknown":
            self = .unknown
        default:
            self = .unknown
        }
    }
}
