//
//  DetailViewController.swift
//  Be a Hero
//
//  Created by Salavat Khanov on 3/18/15.
//  Copyright (c) 2015 Arty Technology. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var dataManager: DataManager?
    var kingdom: Kingdom!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(tableView, selector: "reloadData", name: DataManagerDidUpdateDataNotification, object: nil)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        title = kingdom.name
        dataManager?.updateKingdomData(kingdom)
        tableView.rowHeight = UITableViewAutomaticDimension // allow the self-sizing cell mechanism to work
        tableView.estimatedRowHeight = 174
        tableView.reloadData()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(tableView, name: DataManagerDidUpdateDataNotification, object: nil)
    }

    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(kingdom.quests.count) + 1 // +1 cell to display Kingdom information
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("KingdomInfoCell", forIndexPath: indexPath) as KingdomInfoTableViewCell
            cell.populationNumberLabel.text = "\(kingdom.population)"
            cell.climateLabel.text = kingdom.climate
            cell.kingdomPhotoView.image = kingdom.image
            return cell
            
        default:
            let quest = kingdom.quests[UInt(indexPath.row-1)] as Quest
            let cell = tableView.dequeueReusableCellWithIdentifier("QuestInfoCell", forIndexPath: indexPath) as QuestIngoTableViewCell
            cell.questNameLabel.text = quest.name
            cell.questDescriptionLabel.text = !isEmpty(quest.infoText) ? quest.infoText : "No quest description provided."
            cell.giverPhotoView.image = quest.giver.image
            cell.giverNameLabel.text = quest.giver.name
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
}


class KingdomInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var populationNumberLabel: UILabel!
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var kingdomPhotoView: UIImageView!
}

class QuestIngoTableViewCell: UITableViewCell {
    @IBOutlet weak var questNameLabel: UILabel!
    @IBOutlet weak var questDescriptionLabel: UILabel!
    @IBOutlet weak var giverNameLabel: UILabel!
    @IBOutlet weak var giverPhotoView: UIImageView!
}