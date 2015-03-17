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
    
    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var image: String = ""
    
    // Bad name. Ideally, should have named it 'image' but that name is already used and mapped to match API.
    var photo: UIImage? {
        if let imageData = NSData(contentsOfURL: NSURL(string: image)!) {
            return UIImage(data: imageData)
        }
        return nil
    }
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    override class func ignoredProperties() -> [AnyObject]! {
        return ["photo"]
    }
}
