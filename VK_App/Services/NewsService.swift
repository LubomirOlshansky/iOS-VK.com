//
//  NewsSeviceTableViewController.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 08/01/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class NewsService: UITableViewController {
    
    
    typealias loadNewsDataCompletion = ([News]) -> Void
    
    let baseUrl = "https://api.vk.com"
    let apiKey = "2ea175bdffbe454d02f08ad05d5447e72028fd0a417977ae99ffd8588eedec83012891a4577723184af8d"
    
    func loadNewsData(completion: @escaping loadNewsDataCompletion){
        
        let path = "/method/newsfeed.get"
        let parameters: Parameters = [
            "filters": "post",
            "access_token": apiKey,
            "v": "5.68",
            ]
        let url = baseUrl+path
        
        
            
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { repsons in
            guard let data = repsons.value else { return }
            
            let json = JSON(data)
            
            let news = json["response"]["items"].flatMap { News(json: $0.1) }
            
            completion(news)
            
        }
    }
    
}

