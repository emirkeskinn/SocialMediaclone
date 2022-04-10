//
//  UploadViewController.swift
//  deneme2
//
//  Created by Emir Keskin on 7.04.2022.
//

import UIKit
import Firebase


class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelText: UITextField!
    @IBOutlet weak var upload: UIButton!
    @IBOutlet weak var yukleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.layer.cornerRadius = 10
        yukleButton.layer.cornerRadius = 16
        
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func gorselSec() {
        let pickerComtroller = UIImagePickerController()
        pickerComtroller.delegate = self
        pickerComtroller.sourceType = .photoLibrary
        present(pickerComtroller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func uyariMesaji(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }


    
    @IBAction func upLoadTiklandi(_ sender: Any) {
        
        
        
        
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data, metadata: nil) { (metadata, error) in
                
                if error != nil {
                    self.uyariMesaji(titleInput: "error", messageInput: error?.localizedDescription ?? "hata var")
                    
                } else {
                    imageReferance.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            //DATABASE
                            
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference : DocumentReference? = nil
                            
                            
                            
                            
                            firestoreReference?.delete(completion: { (error) in // bunu sil, öylesine yazdım
                            })
                            
                            
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "PostBy" : Auth.auth().currentUser!.email!, "PostComment" : self.labelText.text!, "Date": FieldValue.serverTimestamp(), "Likes": 0 ] as [String : Any]
                        
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                
                                self.uyariMesaji(titleInput: "Dikkat", messageInput: error?.localizedDescription ?? "hata var gardaşım")
                            
                            
                        } else {
                            
                            self.imageView.image = UIImage(named: "gorselsec.jpg")
                            self.labelText.text = ""
                            self.tabBarController?.selectedIndex = 0
                        }
                            })
                    }
                }
            }
            
            
        }
    }
}

}
