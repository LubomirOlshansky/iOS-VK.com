//
//  Group.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 29/09/2017.
//  Copyright © 2017 Lubomir Olshansky. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import SwiftyJSON

class Group : Object {
    @objc  dynamic var name = ""
    @objc  dynamic  var photo = ""
    
    convenience init(json: JSON) {
        self.init()
        self.name = json["name"].stringValue
        self.photo = json["photo_50"].stringValue
    }
}



