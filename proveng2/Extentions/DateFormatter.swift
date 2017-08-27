//
//  DateFormatter.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import UIKit

extension DateFormatter {

    static func dayFormatter(format: String, timeZone: TimeZone? = TimeZone.autoupdatingCurrent, dateStyle: Style? = .none) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        if dateStyle != .none {
            dateFormatter.dateStyle = dateStyle!
        }
        dateFormatter.locale = Locale(identifier: "en-US")
        return dateFormatter
    }

}

