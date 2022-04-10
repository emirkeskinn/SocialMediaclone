//
//  FeedViewController.swift
//  deneme2
//
//  Created by Emir Keskin on 7.04.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var userMailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
    }
    
    func getDataFromFirestore()  {
        let fireStoreDatabase = Firestore.firestore()
        
        /*
        let settings = fireStoreDatabase.settings
        settings.areTimestampsInSnapshotsEnabled = true
        fireStoreDatabase.settings = settings
        */
        
        fireStoreDatabase.collection("Posts").order(by: "Date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription ?? "hata")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userMailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)
                        
                        if let PostBy = document.get("PostBy") as? String {
                            self.userMailArray.append(PostBy)
                        }
                        if let PostComment = document.get("PostComment") as? String {
                            self.userCommentArray.append(PostComment)
                        }
                        if let Likes = document.get("Likes") as? Int {
                            self.likeArray.append(Likes)
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.userImageArray.append(imageUrl)
                        }
                            
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userMailArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.kullaniciEmailLabel.text = userMailArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.yorumLabel.text = userCommentArray[indexPath.row]
        //cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.documentIdLabel.text = documentIdArray[indexPath.row]
        //cell.userImageView.image = UIImage(named: "ferrrari.jpg")  //(bir sıkıntı yaşamıştım tedbir amaçlı koyuyorum)
        return cell
    }
    
}
