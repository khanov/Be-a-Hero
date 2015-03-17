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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(tableView, selector: "reloadData", name: DataManagerDidUpdateDataNotification, object: nil)
        dataManager.updateData()
    }
    
    @IBAction func logOutButtonDidPress(sender: UIBarButtonItem) {
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        appDelegate?.logOut()
        
        let signUpVC = storyboard?.instantiateViewControllerWithIdentifier("SignUpViewController") as SignUpViewController
        signUpVC.modalTransitionStyle = .FlipHorizontal
        presentViewController(signUpVC, animated: true, completion: nil)
    }
    
    // Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.kingdomCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("KingdomCell", forIndexPath: indexPath) as UITableViewCell
        let kingdom = dataManager.kingdomAtIndex(indexPath.row)
        
        cell.textLabel?.text = kingdom.name
        cell.imageView?.image = kingdom.photo
        
        return cell
    }
    
}
