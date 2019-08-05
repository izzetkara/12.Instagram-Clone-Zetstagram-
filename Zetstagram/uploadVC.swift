//
//  SecondViewController.swift
//  Zetstagram
//
//  Created by İzzet Kara on 4.08.2019.
//  Copyright © 2019 Zetworks. All rights reserved.
//

import UIKit
import Firebase

class uploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    /*---------------------- postButtonClicked ile aynı buton. -------------------*/
    //Bunu neden buraya tanımladım ? Çünkü, post butonuna basıldığında aktif olup olmamasını yönetmek için.
    @IBOutlet weak var uploadButtonClicked: UIButton!
     /*------------------------------- END ------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
    /*---------------------- SELECT IMAGE FROM GALLERY -------------------*/
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
/*-------------------------------------------------------- END -----------------------------------------------*/
    
/*----------------------------------------------- POST BUTTON ----------------------------------------*/
    @IBAction func postButtonClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
               
                if error != nil {
                    self.alert(titleAlert: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                } else {
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            
     /*---------------------- START OF DATABASE-------------------*/

                let fireStoreDataBase = Firestore.firestore()
                           
                            var fireStoreRef : DocumentReference? = nil
                            
                            let fireStorePost = ["imageURL" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email as Any, "postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            
                            fireStoreRef = fireStoreDataBase.collection("Posts").addDocument(data: fireStorePost, completion: { (error) in
                                if error != nil {
                                    self.alert(titleAlert: "ERROR!", messageInput: error?.localizedDescription ?? "Error")
                                } else {
                                    self.imageView.image = UIImage(named: "selectimage.png")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0 //Tabbar da ki bölmeler 0,1,2 ... diye sıralanır.
                                }
                            })
                            
                            
     /*---------------------- END OF DATABASE -------------------*/

                        }
                    }
                }
                
            }
        }
    }
   /*---------------------- POST BUTTON END -------------------*/
    
    /*---------------------- ALERT FUNCTION -------------------*/
    func alert(titleAlert: String, messageInput: String) {
        let alert = UIAlertController(title: titleAlert , message: messageInput , preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    /*---------------------- END ------------------------------*/
}

