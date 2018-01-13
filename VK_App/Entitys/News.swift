//
//  News.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 08/01/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import SwiftyJSON

class News: Object {
    @objc  dynamic var type = ""
    @objc  dynamic var text = ""
    @objc  dynamic var autorName = ""
    @objc  dynamic var autorPhoto = ""
    @objc  dynamic var image = ""
    @objc  dynamic var reposts = 0
    @objc  dynamic var comments = 0
    @objc  dynamic var likes = 0
    @objc  dynamic var views = 0
    
    
    convenience init(json: JSON) {
        self.init()
        self.type = json["type"].stringValue
        self.text = json["text"].stringValue
        self.comments = json["comments"]["count"].intValue
        self.likes = json["likes"]["count"].intValue
        self.reposts = json["reposts"]["count"].intValue
        self.views = json["views"]["count"].intValue
        self.image = json["attachments"]["photo"]["photo_130"].stringValue
        
        
        
    }
}


