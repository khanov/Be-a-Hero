//
//  Model+JSON.swift
//  Be a Hero
//
//  Created by Salavat Khanov on 3/18/15.
//  Copyright (c) 2015 Arty Technology. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Kingdom {
    func populateWithJSON(json: JSON) {
        id = json["id"].int!
        name = json["name"].string!
        
        if let population = json["population"].int {
            self.population = population
        }
        if let climate = json["climate"].string {
            self.climate = climate
        }
        
        let imageURL = NSURL(string: json["image"].string!)!
        if let imageData = NSData(contentsOfURL: imageURL) {
            self.imageData = imageData
        }
        
        if let questJSONArray = json["quests"].array {
            for questJSON in questJSONArray {
                let quest = Quest()
                quest.populateWithJSON(questJSON)
                quests.addObject(quest)
            }
        }
    }
}

extension Quest {
    func populateWithJSON(json: JSON) {
        id = json["id"].int!
        name = json["name"].string!
        
        if let imageURL = json["image"].string {
            if let imageData = NSData(contentsOfURL: NSURL(string: imageURL)!) {
                self.imageData = imageData
            }
        }
        
        if let infoText = json["description"].string {
            self.infoText = infoText
        }
        
        let giver = Giver()
        giver.populateWithJSON(json["giver"])
        self.giver = giver
    }
}

extension Giver {
    func populateWithJSON(json: JSON) {
        id = json["id"].int!
        name = json["name"].string!
        
        let imageURL = NSURL(string: json["image"].string!)!
        if let imageData = NSData(contentsOfURL: imageURL) {
            self.imageData = imageData
        }
    }
}