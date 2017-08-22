//
//  RealmMigration.swift
//  proveng2
//
//  Created by Viktoria on 8/22/17.
//  Copyright © 2017 Provectus. All rights reserved.
//

import Foundation
import  RealmSwift

class RealmMigration {
    let config = Realm.Configuration(
        schemaVersion: 3,
        migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < 3 {
                // Realm will automatically detect new properties and removed properties
                // And will update the schema on disk automatically
                // here can update any value
            }
    })
}
// write "Realm.Configuration.defaultConfiguration = RealmMigration.config"
// in main view controller to viewDidLoad method
// for useing migration
