//
//  FirstViewController.swift
//  Zetstagram
//
//  Created by İzzet Kara on 4.08.2019.
//  Copyright © 2019 Zetworks. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class feedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    /*---------------------- To use GET DATA FROM FIRESTORE -------------------*/
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    
    var documentIDArray = [String]()
    
      /*---------------------- To use GET DATA FROM FIRESTORE END -------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore()
    }

    /*---------------------- TABLEVIEW SETTINGS -------------------*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.documentIDLabel.text = documentIDArray[indexPath.row]
        return cell
    }
     /*---------------------- TABLEVIEW SETTINGS END -------------------*/
    
    /*---------------------- GET DATA FROM FIRESTORE -------------------*/
    
    func getDataFromFirestore() {
        let firestoreDataBase = Firestore.firestore()
      /*  let settings = firestoreDataBase.settings
         settings.areTimestampsInSnapshotsEnabled = true (Eger enabled degil ise bunu yap. Yoksa tarihi eklemek de problem cikabilir. */
        firestoreDataBase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    
                    self.documentIDArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                       let documentID = document.documentID
                        self.documentIDArray.append(documentID)
                        
                        if let postedBy = document.get("postedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        if let postComment = document.get("postComment") as? String {
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int {
                            self.likeArray.append(likes)
                        }
                        if let imageURL = document.get("imageURL") as? String {
                            self.userImageArray.append(imageURL)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    /*---------------------- GET DATA FROM FIRESTORE END -------------------*/
}

