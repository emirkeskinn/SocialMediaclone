//
//  ViewController.swift
//  deneme2
//
//  Created by Emir Keskin on 6.04.2022.
//

import UIKit
import Firebase
import SwiftUI

class ViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var sifreText: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
    }

    @IBAction func sigInTiklandi(_ sender: Any) {
        if emailText.text != "" && sifreText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: sifreText.text!) { authdata, error in
                
                if error != nil {
                    self.hataMesaji(titleInput: "DİKKAT", messageInput: error?.localizedDescription ?? "hata var")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                }
            }
            
            
        } else {
          hataMesaji(titleInput: "DİKKAT", messageInput: "HATA VAR_else")
        }
        
    }
    
    @IBAction func signUpTiklandi(_ sender: Any) {
        
        if emailText.text != "" && sifreText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: sifreText.text!) { authdata, error in
               
                if error != nil {
                    self.hataMesaji(titleInput: "Dikkat", messageInput: "error")
                    
                }  else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            hataMesaji(titleInput: "Dikkat", messageInput: "email / şifre girilmedi")
        }
    }
    func hataMesaji(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let  okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

