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

class BaseCollectionViewController: UICollectionViewController {

    var nextPage = 1
    var photos = UnsplashPhotos() {
        didSet {
            if photos.count % UnsplashRequest.Router.perPage == 0 {
                nextPage = photos.count / UnsplashRequest.Router.perPage + 1
                print("old \(oldValue.count) new \(photos.count)  new nextPage \(nextPage)")
            } else {
                print("not change nextPage \(nextPage)")
            }
        }
    }
    
    var columnCount: Int {
        get {
            if let layout = collectionViewLayout as? WaterfallLayout {
                return layout.numberOfColumns
            } else {
                return 1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(didChangeOrientationHandler),
                           name: UIApplication.didChangeStatusBarOrientationNotification,
                           object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateLayout()
    }
    
    @objc func didChangeOrientationHandler() {
        updateLayout()
    }
    
    func updateLayout() {
        if let layout = collectionViewLayout as? WaterfallLayout {
            layout.delegate = self
            layout.numberOfColumns = 2
        } else {
            print("Not WaterfallLayout")
        }
    }
    
    // MARK: - Configuration
    
    func configureCell(_ cell: UICollectionViewCell, photo: UnsplashPhoto, indexPath: IndexPath) {
        if let photoCell = cell as? PhotoCollectionViewCell {
            photoCell.photoView.layer.cornerRadius = 8
            if let hexColorString = photo.color {
                photoCell.photoView.backgroundColor = UIColor.hexStringToUIColor(hex: hexColorString)
            }
            Alamofire.request(photo.urls.thumb).responseImage { response in
                if let image = response.result.value {
                    let roundedImage = image.af_imageScaled(to: photoCell.photoView.bounds.size).af_imageRounded(withCornerRadius: photoCell.photoView.layer.cornerRadius)
                    photoCell.photoView.image = roundedImage
                }
            }
            
            photoCell.photoLabel.text = String(indexPath.item)
        }
    }
    
    // MARK: - Data
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
}

extension BaseCollectionViewController: WaterfallLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let photo = photos[indexPath.item]
        return CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
    }
    
}
