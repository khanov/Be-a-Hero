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
    
    func updateListData() {
        fetchKingdomList()
    }
    
    func updateKingdomData(kingdom: Kingdom) {
        fetchKingdomDetailsWithID(kingdom.id)
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
        println("Fetching Kingdom list...")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Alamofire.request(.GET, APIKingdomsURL).responseJSON { (_, _, jsonData, error) in
            
            if error != nil {
                println("Error fetching Kingdom list: \(error)")
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                return
            }
            
            Async.utility {
                // Persist
                let realm = RLMRealm.defaultRealm()
                for (_, kingdomJSON) in JSON(jsonData!) {
                    realm.beginWriteTransaction()
                    self.addOrUpdateKingdomWithJSON(kingdomJSON, inRealm: realm)
                    realm.commitWriteTransaction()
                }
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                println("Kingdom list data fetched and cached successfully.")
            }
        }
    }
    
    private func fetchKingdomDetailsWithID(id: Int) {
        println("Fetching Kingdom details...")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let kingdomDetailURL = NSURL(string: String(id), relativeToURL: APIKingdomsURL)!
        Alamofire.request(.GET, kingdomDetailURL).responseJSON { (_, _, jsonData, error) in
            
            if error != nil {
                println("Error fetching Kingdom details: \(error)")
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                return
            }
            
            Async.utility {
                // Persist
                let realm = RLMRealm.defaultRealm()
                realm.beginWriteTransaction()
                
                let kingdomJSON = JSON(jsonData!)
                self.addOrUpdateKingdomWithJSON(kingdomJSON, inRealm: realm)
                
                realm.commitWriteTransaction()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                println("Detail info for Kingdom[ID = \(id)] fetched and cached successfully.")
            }
            
        }
    }
    
    private func addOrUpdateKingdomWithJSON(kingdomJSON: JSON, inRealm realm: RLMRealm) {
        // Get already persisted kingdom (if exists)
        let id = kingdomJSON["id"].int!
        var kingdom = Kingdom.objectsWhere("id = \(id)").firstObject() as? Kingdom
        
        if kingdom == nil {
            // No kingdom with this ID is persisted. Gotta create one.
            kingdom = Kingdom()
            kingdom!.id = id
            realm.addOrUpdateObject(kingdom)
        }
        
        kingdom?.populateWithJSON(kingdomJSON)
        println("Local cache updated Kingdom[ID = \(id)]: success")
    }
    
    deinit {
        RLMRealm.defaultRealm().removeNotification(notificationToken)
    }
}

