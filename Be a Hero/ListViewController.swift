//
//  KingdomListViewController.swift
//  Be a Hero
//
//  Created by Salavat Khanov on 3/14/15.
//  Copyright (c) 2015 Arty Technology. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    let dataManager = DataManager()
    
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(tableView, selector: "reloadData", name: DataManagerDidUpdateDataNotification, object: nil)
        dataManager.updateListData()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(tableView, name: DataManagerDidUpdateDataNotification, object: nil)
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.kingdomCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("KingdomCell", forIndexPath: indexPath) as KingdomListTableViewCell
        let kingdom = dataManager.kingdomAtIndex(indexPath.row)
        
        cell.nameLabel?.text = kingdom.name
        cell.photoView?.image = kingdom.image
        
        return cell
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.alpha = 0.7
    }
    
    override func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.alpha = 1.0
    }
    
    
    // MARK: - Navigation
    
    @IBAction func logOutButtonDidPress(sender: UIBarButtonItem) {
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        appDelegate?.logOut()
        
        let signUpVC = storyboard?.instantiateViewControllerWithIdentifier("SignUpViewController") as SignUpViewController
        signUpVC.modalTransitionStyle = .FlipHorizontal
        presentViewController(signUpVC, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showKingdomDetails" {
            if let selectedRow = tableView.indexPathForSelectedRow()?.row {
                let kingdomDetailViewController = segue.destinationViewController as DetailViewController
                kingdomDetailViewController.kingdom = dataManager.kingdomAtIndex(selectedRow)
                kingdomDetailViewController.dataManager = dataManager
            }
        }
    }
    
}

class KingdomListTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
}