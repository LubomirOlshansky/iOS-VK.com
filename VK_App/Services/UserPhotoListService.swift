//
//  UserPhotoListService.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 30/12/2017.
//  Copyright © 2017 Lubomir Olshansky. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class UserPhotoListService: UITableViewController {
    
    
    typealias loadPhotoDataCompletion = ([Photos]) -> Void
    
    let baseUrl = "https://api.vk.com"
    let apiKey = "2ea175bdffbe454d02f08ad05d5447e72028fd0a417977ae99ffd8588eedec83012891a4577723184af8d"
    
    func loadPhotoData(completion: @escaping loadPhotoDataCompletion){
        
        let path = "/method/photos.getAll"
        let parameters: Parameters = [
            "access_token": apiKey,
            "v": "5.68",
            ]
        let url = baseUrl+path
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { repsons in
            guard let data = repsons.value else { return }
            
            let json = JSON(data)
            
            
            let photos = json["response"]["items"].flatMap { Photos(json: $0.1) }
            
            completion(photos)
            
        }
        
    }
}

