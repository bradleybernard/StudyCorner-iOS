//
//  RegisterViewController.swift
//  StudyCorner-IOS
//
//  Created by Spencer Albrecht on 1/29/16.
//  Copyright © 2016 Brad Bernard. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var cruzID: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var goldPassword: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Register"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func completeEmail(sender: AnyObject) {
        email.text = cruzID.text!+"@ucsc.edu"
    }
    
    @IBAction func completePass(sender: AnyObject) {
        password.text = goldPassword.text!
    }

    @IBAction func submitPressed(sender: AnyObject) {
        let parameters = [
            "cruz_id": cruzID.text!,
            "email": email.text!,
            "password": password.text!,
            "gold_password": goldPassword.text!,
        ]
        
        Alamofire.request(.POST, "http://45.33.18.17/api/user/create", parameters: parameters)
            // HTTP body: foo=bar&baz[]=a&baz[]=1&qux[x]=1&qux[y]=2&qux[z]=3
        .responseJSON { response in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling GET on /posts/1")
                print(response.result.error!)
                return
            }
            
            if let value: AnyObject = response.result.value {
                // handle the results as JSON, without a bunch of nested if loops
                let post = JSON(value)
                //print("The post is: " + post.description)
                if post["success"].boolValue == true {
                    print(post)
                    let registerVC = self.storyboard!.instantiateViewControllerWithIdentifier("vc")
                    self.navigationController?.pushViewController(registerVC, animated: true)
                    
                } else {
                    print("Error")
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    */

}
