//
//  LoginViewController.swift
//  Proj Insight
//
//  Created by Mackenzie Kary on 2016-12-04.
//  Copyright © 2016 Mackenzie Kary. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseCore
import FirebaseDatabase


/*
 USERNAME needs to be a real email (needs an @ symbol)
 AND***
 Password needs to be at least 6 characters long
 */
class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    var isNewUser: DarwinBoolean = false
    
    let loginToStudy = "LoginToStudy"
    @IBAction func loginSelected(_ sender: Any) {
        FIRAuth.auth()!.signIn(withEmail: textFieldLoginEmail.text!,
                               password: textFieldLoginPassword.text!) { user, error in
                                if error != nil {
                                    let alert = UIAlertController(title: "Invalid Login!", message: "Please try again.", preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                    // show the alert
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
        }
        textFieldLoginEmail.text = ""
        textFieldLoginPassword.text = ""
        self.performSegue(withIdentifier: self.loginToStudy, sender: nil)
    }
    @IBAction func signUpSelected(_ sender: Any) {
        let alert = UIAlertController(title: "Sign Up",
                                      message: "Please enter information below",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        let emailField = alert.textFields![0]
                                        let passwordField = alert.textFields![1]
                                        
                                        FIRAuth.auth()!.createUser(withEmail: emailField.text!,
                                                                   password: passwordField.text!) { user, error in
                                                                    if error == nil {
                                                                        FIRAuth.auth()!.signIn(withEmail: self.textFieldLoginEmail.text!,
                                                                                               password: self.textFieldLoginPassword.text!)
                                                                        self.isNewUser = true
                                                                        if let pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as? PageViewController {
                                                                           // self.isNewUser = true
                                                                            print("Got here first")
                                                                            self.present(pageViewController, animated: true, completion: nil)
                                                                        }

                                                                    }else{
                                                                        let alert = UIAlertController(title: "Invalid Login", message: "Email format must be: \"<youremail>@<domain>\"\nPassword must be at least 6 characters.", preferredStyle: UIAlertControllerStyle.alert)
                                                                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                                                        // show the alert
                                                                        self.present(alert, animated: true, completion: nil)
                                                                    }
                                        }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter password (Min 6 characters)"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldLoginEmail.delegate = self
        textFieldLoginPassword.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        FIRAuth.auth()?.addStateDidChangeListener() { auth, user in
            if user != nil && self.isNewUser == false {
                print("\n\n HERE")
                //self.performSegue(withIdentifier: self.loginToStudy, sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    @IBAction func unwindToLoginPage(_ sender: UIStoryboardSegue) {
        do {
            try FIRAuth.auth()!.signOut()
            self.isNewUser = false
            //dismiss(animated: true, completion: nil)
        } catch {
            
        }
    }

    
    
    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Send email and password to firebase, if not in DB, then cancel segue. 
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
