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
    
    let userFriendListService = UserFriendListService()
    var token: NotificationToken?
    var responce: Results<FriendRealm>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pairTableAndRealm()
        userFriendListService.loadFriendsData()
    }
    
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        responce = realm.objects(FriendRealm.self)
        
        token = responce.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
                break
            case .error(let error):
                fatalError("\(error)")
                break
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responce.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserFriendListCell", for: indexPath) as! UserFriendListCell
        
        cell.friendName.text = responce[indexPath.row].name + " " + responce[indexPath.row].surname
        print(responce[indexPath.row].name)
        
        cell.contentView.backgroundColor = UIColor.darkGray
        cell.backgroundColor = UIColor.darkGray
        
        if let imageURL = URL(string: responce[indexPath.row].photo
            
            ) {
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

