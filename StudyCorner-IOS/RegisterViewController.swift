//
//  RegisterViewController.swift
//  StudyCorner-IOS
//
//  Created by Spencer Albrecht on 1/29/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    // Fields
    @IBOutlet weak var cruzID: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var goldPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        cruzID.delegate = self
        cruzID.tag = 1
        cruzID.autocorrectionType = .No
        goldPassword.delegate = self
        goldPassword.tag = 2
        goldPassword.autocorrectionType = .No
        email.delegate = self
        email.tag = 3
        email.autocorrectionType = .No
        password.delegate = self
        password.tag = 4
        password.autocorrectionType = .No
        
        self.title = "Register"
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        // Do any additional setup after loading the view.
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // Auto-completes email field when button pressed
    @IBAction func completeEmail(sender: AnyObject) {
        email.text = cruzID.text!+"@ucsc.edu"
    }
    
    // Auto-completes pass field when button pressed
    @IBAction func completePass(sender: AnyObject) {
        password.text = goldPassword.text!
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTag: NSInteger = textField.tag + 1;
        // Try to find next responder
        if let nextResponder: UIResponder! = textField.superview!.viewWithTag(nextTag){
            nextResponder.becomeFirstResponder()
        }
        else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        return false // We do not want UITextField to insert line-breaks.
    }
    
    // Submits all user data when pressed
    @IBAction func submitPressed(sender: AnyObject) {
        let parameters = [
            "cruz_id": cruzID.text!,
            "email": email.text!,
            "password": password.text!,
            "gold_password": goldPassword.text!,
        ]
        
        Alamofire.request(.POST, "http://45.33.18.17/api/user/create", parameters: parameters)
            
            // Reads the response from the server after post
            .responseJSON { response in
                
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /posts/1")
                    print(response.result.error!)
                    return
                }
                
                // Runs if we get a response from the server
                if let value: AnyObject = response.result.value {
                    let post = JSON(value)
                    
                    // Conditional that checks if the user info has been
                    // properly stored in the datdabase
                    if post["success"].boolValue == true {
                        
                        // Changes view to the loading page
                        let loadingVC = self.storyboard!.instantiateViewControllerWithIdentifier("LoadingVC") as! LoadingViewController
                        
                        // Stores our user_id given to us by server
                        loadingVC.user_id = post["user_id"].stringValue
                        
                        self.navigationController?.pushViewController(loadingVC, animated: true)
                        
                    }
                    else {
                        print("Error")
                    }
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}