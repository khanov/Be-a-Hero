//
//  KingdomListViewController.swift
//  Be a Hero
//
//  Created by Salavat Khanov on 3/14/15.
//  Copyright (c) 2015 Arty Technology. All rights reserved.
//

import UIKit

class KingdomListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutButtonDidPress(sender: UIBarButtonItem) {
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        appDelegate?.logOut()
        
        let signUpVC = storyboard?.instantiateViewControllerWithIdentifier("SignUpViewController") as SignUpViewController
        signUpVC.modalTransitionStyle = .FlipHorizontal
        presentViewController(signUpVC, animated: true, completion: nil)
    }
    
}
