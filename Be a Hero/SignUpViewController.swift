//
//  ViewController.swift
//  Be a Hero
//
//  Created by Salavat Khanov on 3/14/15.
//  Copyright (c) 2015 Arty Technology. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var verticalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomSpaceConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accentColor = UIColor(red: 112/255.0, green: 161/255.0, blue: 221/255.0, alpha: 1.0)
        let tintColor = UIColor(red: 141/255.0, green: 54/255.0, blue: 142/255.0, alpha: 1.0)
        
        for textField in [nameTextField, emailTextField] {
            textField.layer.borderColor = accentColor.CGColor
            textField.backgroundColor = UIColor.clearColor()
            textField.tintColor = tintColor
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 5.0
            textField.delegate = self
        }
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSForegroundColorAttributeName: accentColor])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName: accentColor])

        submitButton.layer.cornerRadius = 5.0
        updateSubmitButtonState()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }

    
    // MARK: Keyboard
    
    func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo
        let kbRect = info![UIKeyboardFrameEndUserInfoKey]!.CGRectValue()
        let kbCoordinates = view.convertRect(kbRect, fromView: nil)
        
        bottomSpaceConstraint.constant = kbCoordinates.height
        verticalCenterConstraint.active = false
        bottomSpaceConstraint.active = true
    }
    
    func keyboardWillHide(notification: NSNotification) {
        bottomSpaceConstraint.active = false
        verticalCenterConstraint.active = true
    }

    
    // MARK: Text Fields
    
    @IBAction func textFieldDidChangeEditing(sender: UITextField) {
        updateSubmitButtonState()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if nameTextField.isFirstResponder() {
            emailTextField.becomeFirstResponder()
        } else if emailTextField.isFirstResponder() {
            emailTextField.resignFirstResponder()
        }
        return true
    }
    
    
    // MARK: Submit Button
    
    @IBAction func submitButtonDidTouch(sender: UIButton) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        appDelegate?.signUpWithName(nameTextField.text, email: emailTextField.text)
        
        let params = ["email": emailTextField.text, "name": nameTextField.text]
        Alamofire.request(.POST, APISubscribeURL, parameters: params).responseJSON { (_, _, JSON, error) in
            
            println(JSON)
            self.performSegueWithIdentifier("showListNavigationController", sender: self)
        }
    }
    
    func updateSubmitButtonState() {
        
        let bothFieldsHaveText = !isEmpty(nameTextField.text) && !isEmpty(emailTextField.text)
        let emailIsValid = emailTextField.text.containsEmailAddress
        
        submitButton.enabled = bothFieldsHaveText && emailIsValid
        submitButton.alpha = submitButton.enabled ? 1.0 : 0.5
    }
    
}

