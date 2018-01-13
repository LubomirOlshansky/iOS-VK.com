//
//  FriendPhotoConroller.swift
//  VK_App
//
//  Created by Lubomir Olshansky on 22/09/2017.
//  Copyright © 2017 Lubomir Olshansky. All rights reserved.
//

import UIKit

class FriendPhotoConroller: UICollectionViewController {

    let userPhotoListService = UserPhotoListService()
    var responcePhoto = [Photos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userPhotoListService.loadPhotoData() { [weak self]
            responce in
            self?.responcePhoto = responce
            self?.collectionView?.reloadData()
        }
    }
    
    
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return responcePhoto.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotoCell", for: indexPath) as! PhotosCell
        
        cell.contentView.backgroundColor = UIColor.darkGray
        cell.backgroundColor = UIColor.darkGray
        
        if let imageURL = URL(string: responcePhoto[indexPath.row].photo

            ) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.photo.image = image
                    }
                }
            }
        }
        return cell
    }
}

