//
//  Photos.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 30/12/2017.
//  Copyright © 2017 Lubomir Olshansky. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import SwiftyJSON

class Photos: Object {
    @objc  dynamic var photo = ""
    
    convenience init(json: JSON) {
        self.init()
        self.photo = json["photo_604"].stringValue
    }
}


