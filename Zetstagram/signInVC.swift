//
//  sıgnInVC.swift
//  Zetstagram
//
//  Created by İzzet Kara on 4.08.2019.
//  Copyright © 2019 Zetworks. All rights reserved.
//

import UIKit
import Firebase

class signInVC: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
/*---------------------- SIGN IN -------------------*/
    @IBAction func signInClicked(_ sender: Any) {
        
        if emailText.text! != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authResult, error) in
                if error != nil {
                    self.alert(titleAlert: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            alert(titleAlert: "Error", messageInput: "Username/Password")
        }
    }
/*---------------------- END ------------------------------*/
        
   
/*---------------------- SIGN UP -------------------*/
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailText.text! != "" && passwordText.text != "" {
        
        Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authResult , error) in
            if error != nil {
                self.alert(titleAlert: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
          self.alert(titleAlert: "Error", messageInput: "Username/Password")
        }
    }
/*---------------------- END ------------------------------*/
    
/*---------------------- ALERT FUNCTION -------------------*/
    func alert(titleAlert: String, messageInput: String) {
        let alert = UIAlertController(title: titleAlert , message: messageInput , preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
/*---------------------- END ------------------------------*/
}
