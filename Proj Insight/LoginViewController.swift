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
    
    let loginToStudy = "LoginToStudy"
    @IBAction func loginSelected(_ sender: Any) {
        FIRAuth.auth()!.signIn(withEmail: textFieldLoginEmail.text!,
                               password: textFieldLoginPassword.text!)
        
        textFieldLoginEmail.text = ""
        textFieldLoginPassword.text = ""
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
                                                                        
                                                                        let ref = FIRDatabase.database().reference()
                                                                        
                                                                        ref.child("Users").child((FIRAuth.auth()!.currentUser?.uid)!).child("FirstName").setValue("No First Name Entered")
                                                                        ref.child("Users").child((FIRAuth.auth()!.currentUser?.uid)!).child("LastName").setValue(" No Surname Entered")
                                                                        ref.child("Users").child((FIRAuth.auth()!.currentUser?.uid)!).child("Gender").setValue("No Gender Entered")
                                                                        ref.child("Users").child((FIRAuth.auth()!.currentUser?.uid)!).child("DOB").setValue("No Date of Birth Entered")
                                                                        ref.child("Users").child((FIRAuth.auth()!.currentUser?.uid)!).child("Age").setValue(" No Age Entered")
                                                                        ref.child("Users").child((FIRAuth.auth()!.currentUser?.uid)!).child("AccountType").setValue("Researcher")
                                                                        ref.child("Users").child((FIRAuth.auth()!.currentUser?.uid)!).child("Weight").setValue("No Weight Entered")
                                                                    }
                                        }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldLoginEmail.delegate = self
        textFieldLoginPassword.delegate = self
         print("\n\nHERE did load")
    }
    override func viewDidAppear(_ animated: Bool) {
        FIRAuth.auth()?.addStateDidChangeListener() { auth, user in
            if user != nil {
                print("\n\nHERE did appear")
                self.performSegue(withIdentifier: self.loginToStudy, sender: nil)
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
