//
//  BasicCollectionViewController.swift
//  Discover-Photo
//
//  Created by ERU on 2019/06/01.
//  Copyright © 2019 HackingGate. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class BasicCollectionViewController: UICollectionViewController {

    var nextPage = 1
    var photos = UnsplashPhotos() {
        didSet {
            if photos.count % UnsplashRequest.Router.perPage == 0 {
                nextPage = photos.count / UnsplashRequest.Router.perPage + 1
                print("old \(oldValue.count) new \(photos.count)  new nextPage \(nextPage)")
            } else {
                print("not change nextPage \(nextPage)")
            }
            reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let layout = collectionViewLayout as? WaterfallLayout {
//            layout.delegate = self
//            layout.numberOfColumns = 2
//        } else {
//            print("Not WaterfallLayout")
//        }
        
    }
    
    // MARK: - Configuration
    
    func configureCell(_ cell: UICollectionViewCell, photo: UnsplashPhoto, indexPath: IndexPath) {
        if let photoCell = cell as? PhotoCollectionViewCell {
            
            Alamofire.request(photo.urls.small).responseImage { response in
                if let image = response.result.value {
                    photoCell.photoView.image = image
                }
            }
            
            photoCell.photoLabel.text = String(indexPath.item)
        }
    }
    
    // MARK: - Data
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

extension BasicCollectionViewController: WaterfallLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        let photo = photos[indexPath.item]
        let photoRatio = CGFloat(photo.height) / CGFloat(photo.width)
        let cellWidth = collectionView.bounds.width / 2
        let height = photoRatio * cellWidth
        return height
    }
    
}
