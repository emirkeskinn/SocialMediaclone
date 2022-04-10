//
//  SettingsViewController.swift
//  deneme2
//
//  Created by Emir Keskin on 7.04.2022.
//

import UIKit
import Firebase
class SettingsViewController: UIViewController {

    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.title = "Ayarlar"
    }
    
   
    
    
    
    
    @IBAction func cikisTiklandi(_ sender: Any) {
       
        do {
           try  Auth.auth().signOut()
           performSegue(withIdentifier: "toViewController", sender: nil)
        } catch {
            print("hata")
            
        }
      
       
        
    
     
}
}
