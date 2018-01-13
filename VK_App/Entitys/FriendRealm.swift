//
//  FriendRealm.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 03/10/2017.
//  Copyright © 2017 Lubomir Olshansky. All rights reserved.
//
import UIKit
import Foundation
import RealmSwift
import SwiftyJSON

class FriendRealm: Object {
    @objc  dynamic var id = 0
    @objc  dynamic var name = ""
    @objc  dynamic var surname = ""
    @objc  dynamic var photo = ""
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["uid"].intValue
        self.name = json["first_name"].stringValue
        self.surname = json["last_name"].stringValue
        self.photo = json["photo_50"].stringValue
    }
}


