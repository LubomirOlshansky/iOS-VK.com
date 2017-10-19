//
//  UserFriendListController.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 22/09/2017.
//  Copyright © 2017 Lubomir Olshansky. All rights reserved.
//

import UIKit
import RealmSwift
class UserFriendListController: UITableViewController {
    
    final let url = URL(string: "https://api.vk.com//method/friends.get?fields=nickname,photo_50&access_token=a1d9f905caef6cc4e7814a0dae629d07cb3e44fc6163c5fc3642531f5dd7f5af812310fba07c34556ff18")
    private var response = [Friend]()
    @IBOutlet var friendsTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson()
        tableView.tableFooterView = UIView()
    }
    
    func downloadJson() {
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("something is wrong")
                
                return
            }
            print("downloaded")
            
            do
            {
                let decoder = JSONDecoder()
                let downloadedFriends = try decoder.decode(Friends.self, from: data)
                self.response = downloadedFriends.response
                DispatchQueue.main.async {
                    self.friendsTableView.reloadData()
                }
            } catch {
                print("something wrong after downloaded")
            }
            }.resume()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserFriendListCell") as? UserFriendListCell else { return UITableViewCell() }
        
        cell.friendName.text = response[indexPath.row].first_name + " " + response[indexPath.row].last_name
        
        cell.contentView.backgroundColor = UIColor.darkGray
        cell.backgroundColor = UIColor.darkGray
        
        if let imageURL = URL(string: response[indexPath.row].photo_50) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.friendPhoto.image = image
                    }
                }
            }
        }
        return cell
    }
}


