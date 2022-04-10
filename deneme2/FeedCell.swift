//
//  FeedCell.swift
//  deneme2
//
//  Created by Emir Keskin on 8.04.2022.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {

    @IBOutlet weak var kullaniciEmailLabel: UILabel!
    @IBOutlet weak var yorumLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
  
    @IBOutlet weak var documentIdLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userImageView.layer.cornerRadius = 50
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonTiklandi(_ sender: Any) {
        
        let fireStoreDataBase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!) {
            let likeStore = ["Likes" : likeCount + 1] as [String: Any]
            
            fireStoreDataBase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
        }
    }
}
