//
//  Group.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 29/09/2017.
//  Copyright © 2017 Lubomir Olshansky. All rights reserved.
//

import UIKit
class Responce: Codable {
    let response: Groups
    init(response: Groups) {
        self.response = response
    }
}
class Groups: Codable {
    let count: Int
    let items: [Group]
    init(count: Int, items: [Group]) {
        self.count = count
        self.items = items
    }
}

class Group: Codable {
    let id: Int
    let name: String
    let screen_name: String
    let is_closed: Int
    let type: String
    let is_admin: Int
    let is_member: Int
    let photo_50: String
    let photo_100: String
    let photo_200: String
    
    init(id: Int, name: String, screen_name: String, is_closed: Int, type: String, is_admin: Int, is_member: Int, photo_50: String, photo_100: String, photo_200: String) {
        self.id = id
        self.name = name
        self.screen_name = screen_name
        self.is_closed = is_closed
        self.type = type
        self.is_admin = is_admin
        self.is_member = is_member
        self.photo_50 = photo_50
        self.photo_100 = photo_100
        self.photo_200 = photo_200
    }
}

