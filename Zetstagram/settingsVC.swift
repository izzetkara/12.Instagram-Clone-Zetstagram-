//
//  settingsVC.swift
//  Zetstagram
//
//  Created by İzzet Kara on 4.08.2019.
//  Copyright © 2019 Zetworks. All rights reserved.
//

import UIKit
import Firebase

class settingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
/*---------------------- LOG OUT -------------------*/
    @IBAction func logoutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toSignUpVC", sender: nil)
        } catch  {
        print("Error!")
        }
    }
/*----------------------- END ----------------------*/
    
}
