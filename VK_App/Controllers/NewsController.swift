//
//  NewsController.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 08/01/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

import UIKit
import RealmSwift

class NewsController: UITableViewController {
    
    let newsService = NewsService()
    var responceNews = [News]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsService.loadNewsData() { [weak self]
            responce in
            self?.responceNews = responce
            self?.tableView?.reloadData()
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responceNews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        cell.newsText.text = responceNews[indexPath.row].text
        cell.commentsCount.text = String(responceNews[indexPath.row].comments)
        cell.likesCount.text = String(responceNews[indexPath.row].likes)
        cell.sharesCount.text = String(responceNews[indexPath.row].reposts)
        cell.viewsCount.text = String(responceNews[indexPath.row].views)
        print(responceNews[indexPath.row].image)
        print(responceNews[indexPath.row].reposts)
        print("privet")
        
        
        
        if let imageURL = URL(string: responceNews[indexPath.row].image

            ) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.newsPhoto.image = image
                    }
                }
            }
        }
        return cell
    }
}

