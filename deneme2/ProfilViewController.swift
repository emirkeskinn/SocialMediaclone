//
//  ProfilViewController.swift
//  deneme2
//
//  Created by Emir Keskin on 10.04.2022.
//

import UIKit

class ProfilViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var durumLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        durumLabel.layer.cornerRadius = 20
        
        imageView.backgroundColor = .cyan
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height / 2
        /*
        storyView.backgroundColor = .cyan
        storyView.layer.masksToBounds = true
        storyView.layer.cornerRadius = imageView.frame.height / 2
        */
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
