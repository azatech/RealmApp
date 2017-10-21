//
//  RealmObjects.swift
//  RealmApp
//
//  Created by Azat IOS on 21.10.17.
//  Copyright © 2017 azatech. All rights reserved.
//

import Foundation
import RealmSwift

class User : Object {
    @objc dynamic var name : String? = nil
                  
                  var age = RealmOptional<Int>()

    override static func primaryKey() -> String? {
        return "name"
    }
}

extension User {
    func writeToRealm() {
        try! uiRealm.write {
            uiRealm.add(self, update: true)
        }
    }
}
