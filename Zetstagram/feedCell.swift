//
//  feedCell.swift
//  Zetstagram
//
//  Created by İzzet Kara on 5.08.2019.
//  Copyright © 2019 Zetworks. All rights reserved.
//

import UIKit
import Firebase

class feedCell: UITableViewCell {

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var documentIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    /*---------------------- LIKE BUTTON CLICKED -------------------*/

    @IBAction func likeButtonClicked(_ sender: Any) {
        
        let fireStoreDataBase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!) {
            
            let likeStore = ["likes" : likeCount + 1] as [String : Any]
        
        fireStoreDataBase.collection("Posts").document(documentIDLabel.text!).setData(likeStore, merge: true)
        }
    }
    
    
    /*---------------------- LIKE BUTTON CLICKED -------------------*/
}
