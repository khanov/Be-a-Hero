//
//  Model.swift
//  Be a Hero
//
//  Created by Salavat Khanov on 3/15/15.
//  Copyright (c) 2015 Arty Technology. All rights reserved.
//

import UIKit
import Realm

class Kingdom: RLMObject {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var imageData = NSData()
    dynamic var climate = ""
    dynamic var population = 0
    dynamic var quests = RLMArray(objectClassName: Quest.className())
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    override class func ignoredProperties() -> [AnyObject]! {
        return ["image"]
    }
}

class Quest: RLMObject {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var giver = Giver()
    dynamic var imageData = NSData()
    dynamic var infoText = ""
    
    override class func primaryKey() -> String {
        return "id"
    }
}

class Giver: RLMObject {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var imageData = NSData()
    
    override class func primaryKey() -> String {
        return "id"
    }
}


