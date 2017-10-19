//
//  Friend.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 29/09/2017.
//  Copyright © 2017 Lubomir Olshansky. All rights reserved.
//

import UIKit

class Friends: Codable {
    let response: [Friend]
    
    init(response: [Friend]) {
        self.response = response
    }
}



class Friend: Codable {
    let uid: Int
    let first_name: String
    let last_name: String
    let nickname: String
    let photo_50: String
    let online: Int
    let user_id: Int
    
    
    init(uid: Int, first_name: String, last_name: String, nickname: String, photo_50: String, online: Int, user_id: Int) {
        self.uid = uid
        self.first_name = first_name
        self.last_name = last_name
        self.nickname = nickname
        self.photo_50 = photo_50
        self.online = online
        self.user_id = user_id
        
    }
}

