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
    var token: NotificationToken?
    var responceNews: Results<News>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pairTableAndRealm()
        newsService.loadNewsData()
        
    }
    
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        
        responceNews = realm.objects(News.self)
        
        token = responceNews.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
                break
            case .error(let error):
                fatalError("\(error)")
                break
            }
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
        print(responceNews[indexPath.row].reposts)
        
        
        cell.contentView.backgroundColor = UIColor.darkGray
        cell.backgroundColor = UIColor.darkGray
        
//        if let imageURL = URL(string: responceGroup[indexPath.row].photo
//
//            ) {
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: imageURL)
//                if let data = data {
//                    let image = UIImage(data: data)
//                    DispatchQueue.main.async {
//                        cell.userGroupPhoto.image = image
//                    }
//                }
//            }
//        }
        return cell
    }
}

