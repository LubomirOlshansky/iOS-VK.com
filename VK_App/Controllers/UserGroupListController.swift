//
//  UserGroupListControllerTableViewController.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 22/09/2017.
//  Copyright © 2017 Lubomir Olshansky. All rights reserved.
//

import UIKit
import RealmSwift

class UserGroupListController: UITableViewController {
    
    let userGroupListService = UserGroupListService()
    var token: NotificationToken?
    var responceGroup: Results<Group>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pairTableAndRealm()
        userGroupListService.loadGroupData()
        
        }

func pairTableAndRealm() {
    guard let realm = try? Realm() else { return }
    
    responceGroup = realm.objects(Group.self)
    
    token = responceGroup.observe { [weak self] (changes: RealmCollectionChange) in
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
        return responceGroup.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroupListCell", for: indexPath) as! UserGroupListCell
        
        cell.userGroupName.text = responceGroup[indexPath.row].name
        print(responceGroup[indexPath.row].name)
        
        
        cell.contentView.backgroundColor = UIColor.darkGray
        cell.backgroundColor = UIColor.darkGray
        
        if let imageURL = URL(string: responceGroup[indexPath.row].photo
            
            ) {
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

