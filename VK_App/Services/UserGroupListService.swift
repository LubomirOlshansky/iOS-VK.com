//
//  UserGroupListService.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 30/12/2017.
//  Copyright © 2017 Lubomir Olshansky. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift
class UserGroupListService: UITableViewController {
    
    
    typealias loadGroupDataCompletion = ([Group]) -> Void
    
    let baseUrl = "https://api.vk.com"
    let apiKey = "2ea175bdffbe454d02f08ad05d5447e72028fd0a417977ae99ffd8588eedec83012891a4577723184af8d"
    
    func loadGroupData(){
        
        let path = "/method/groups.get"
        let parameters: Parameters = [
            "extended": "1",
            "access_token": apiKey,
            "v": "5.68",
            ]
        let url = baseUrl+path
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { repsons in
            guard let data = repsons.value else { return }
            
            let json = JSON(data)
            print(json)
            let groups = json["response"]["items"].flatMap { Group(json: $0.1) }
            
            self.saveGroupsData(groups)
            
        }
        
    }
    func saveGroupsData(_ groups: [Group]) {
        do {
            let realm = try Realm()
            let oldData = realm.objects(Group.self)
            
            realm.beginWrite()
            realm.delete(oldData)
            realm.add(groups)
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
    }
}
