//
//  LoginViewController.swift
//  ChatWithParse
//
//  Created by Kavita Gaitonde on 9/27/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signupClicked(_ sender: AnyObject) {
        
        let newUser = PFUser()
        // Set user properties
        newUser.username = emailTextField.text
        newUser.email = emailTextField.text
        newUser.password = passwordTextField.text
        
        // Call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // Segue to logged in view
                self.performSegue(withIdentifier: "chatSegue", sender: nil)
            }
        }
    }
    
    
    
    @IBAction func loginClicked(_ sender: AnyObject) {
        
        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!) {
            (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "chatSegue", sender: nil)
            }
        }
    }
  
}
