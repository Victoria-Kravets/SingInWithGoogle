//
//  Date.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import UIKit

extension Date {

    func makeLocalTime() -> Date {
        let timeZone  = TimeZone(identifier: "Europe/Kiev")
        let UTCString = DateFormatter.dayFormatter(format: "yyyy-MM-dd HH:mm:ss",
                                                   timeZone: timeZone).string(from: self)
        return DateFormatter.dayFormatter(format: "yyyy-MM-dd HH:mm:ss")
            .date(from: UTCString)!
    }
}
