//
//  UserGroupListControllerTableViewController.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 22/09/2017.
//  Copyright © 2017 Lubomir Olshansky. All rights reserved.
//

import UIKit

class UserGroupListControllerTableViewController: UITableViewController {
    
   
   let apiKey = UserDefaults.standard.string(forKey: "apiKey")
    
    final let url = URL(string: "https://api.vk.com//method/groups.get?extended=1&access_token=a1d9f905caef6cc4e7814a0dae629d07cb3e44fc6163c5fc3642531f5dd7f5af812310fba07c34556ff18&v=5.68")
    
    private var group = [Group]()
    
    @IBOutlet var GroupTableView: UITableView!
    
    
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
                let downloadedGroups = try decoder.decode(Responce.self, from: data)
                self.group = downloadedGroups.response.items
                print("decoded")
                DispatchQueue.main.async {
                    self.GroupTableView.reloadData()
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
        return group.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroupListCell") as? UserGroupListCell else { return UITableViewCell() }
        
       cell.userGroupName.text = "Name: " + group[indexPath.row].name
        
        cell.contentView.backgroundColor = UIColor.darkGray
        cell.backgroundColor = UIColor.darkGray
        
        if let imageURL = URL(string: group[indexPath.row].photo_50) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.userGroupPhoto.image = image
                    }
                }
            }
        }
        return cell
    }
}

