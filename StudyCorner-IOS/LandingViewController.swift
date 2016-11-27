//
//  LandingViewController.swift
//  StudyCorner-IOS
//
//  Created by Aidan Gadberry on 1/29/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit
import  Alamofire

class LandingViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        // Do any additional setup after loading the view.
        
    }
    
    // Hides the nav bar
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    
    // Sends user data to server when login is pressed
    @IBAction func loginPressed(sender: AnyObject) {
        let parameters = [
            "email": email.text!,
            "password": password.text!,
        ]
        
        Alamofire.request(.POST, "http://45.33.18.17/api/user/login", parameters: parameters)
        // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
            .responseJSON { response in
                
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /priority")
                    print(response.result.error!)
                    return
                }
                
                // Runs if we get a response from the server
                if let value: AnyObject = response.result.value {
                    let post = JSON(value)
                    print(post)
                    
                    print("what is post success? ")
                    print(post["success"].boolValue)
                    
                    // Conditional that checks if the user info has been
                    // properly stored in the datdabase
                    if post["success"].boolValue == true {
                        let myDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        myDelegate.switchToTabBar(post["id"].stringValue)
                    }
                    else {
                        print("Error")
                    }
                    
                }
                
                
        }
    }
    
    // Changes view to the register page
    @IBAction func registerPressed(sender: AnyObject) {
        let registerVC = self.storyboard!.instantiateViewControllerWithIdentifier("RegistrationVC") as! RegisterViewController
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
