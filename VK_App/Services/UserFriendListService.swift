//
//  UserFriendListService.swift
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

class UserFriendListService: UITableViewController {
    
    
    typealias loadFriendDataCompletion = ([FriendRealm]) -> Void
    
    let baseUrl = "https://api.vk.com"
    let apiKey = "3a450e6028cf2082d66d18120d38ab62e6edf14215a7cbbc929e8567b4afc5a352669b7f811484c548552"
    
    func loadFriendsData(){
        
        let path = "/method/friends.get"
        let parameters: Parameters = [
            "fields": "nickname, photo_50",
            "access_token": apiKey,
            ]
        let url = baseUrl+path
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { repsons in
            guard let data = repsons.value else { return }
            
            let json = JSON(data)
            
            let friends = json["response"].flatMap { FriendRealm(json: $0.1) }
            
            self.saveFriendsData(friends)
            
        }
    }
    func saveFriendsData(_ friends: [FriendRealm]) {
        do {
            let realm = try Realm()
            let oldData = realm.objects(FriendRealm.self)
            
            realm.beginWrite()
            realm.delete(oldData)
            realm.add(friends)
            try realm.commitWrite()
        }
        catch {
            print(error)
        }
    }
}
