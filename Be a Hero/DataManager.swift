//
//  DataManager.swift
//  Be a Hero
//
//  Created by Salavat Khanov on 3/15/15.
//  Copyright (c) 2015 Arty Technology. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Realm

let APISubscribeURL = NSURL(string: "https://challenge2015.myriadapps.com/api/v1/subscribe")!
let APIKingdomsURL = NSURL(string: "https://challenge2015.myriadapps.com/api/v1/kingdoms/")!
let DataManagerDidUpdateDataNotification = "DataManagerDidUpdateDataNotification" // this should be static in the DataManager class, but Swift doesn't support class variables yet


class DataManager {
    
    // MARK: - Public API
    
    func updateData() {
        fetchKingdomList()
    }
    
    var kingdomCount: Int {
        return Int(kingdoms.count)
    }
    
    func kingdomAtIndex(index: Int) -> Kingdom {
        return kingdoms[UInt(index)] as Kingdom
    }
    
    
    // MARK: - Private
    
    private var notificationToken = RLMRealm.defaultRealm().addNotificationBlock { (note, realm) -> Void in
        NSNotificationCenter.defaultCenter().postNotificationName(DataManagerDidUpdateDataNotification, object: nil)
    }
    
    private var kingdoms = Kingdom.allObjects().sortedResultsUsingProperty("id", ascending: true)
    
    private func fetchKingdomList() {
        Alamofire.request(.GET, APIKingdomsURL).responseJSON { (_, _, jsonData, error) in
            if error != nil {
                println("network error: \(error)")
                return
            }
            
            let response = JSON(jsonData!)
            
            // Persist
            let realm = RLMRealm.defaultRealm()
            realm.beginWriteTransaction()
            for (_, kingdomJSON) in response {
                let kingdom = Kingdom()
                kingdom.populateWithJSON(kingdomJSON)
                realm.addOrUpdateObject(kingdom)
            }
            realm.commitWriteTransaction()
            
            println("Kingdom List:")
            println(response)
        }
    }
    
    private func fetchKingdomDetailsWithID(id: Int) {
        let kingdomDetailURL = NSURL(string: String(id), relativeToURL: APIKingdomsURL)!
        println(kingdomDetailURL.absoluteString)
        
        Alamofire.request(.GET, kingdomDetailURL).responseJSON { (_, _, jsonData, error) in
            if error != nil {
                println("network error: \(error)")
                return
            }
            
            let kingdomJSON = JSON(jsonData!)
            
            // Persist
            let realm = RLMRealm.defaultRealm()
            realm.beginWriteTransaction()
            let kingdom = Kingdom()
            kingdom.populateWithJSON(kingdomJSON)
            realm.addOrUpdateObject(kingdom)
            realm.commitWriteTransaction()
            
            println("Kingdom Details:")
            println(kingdomJSON)
        }
    }
    
    deinit {
        RLMRealm.defaultRealm().removeNotification(notificationToken)
    }
}

