//
//  HomeCollectionViewController.swift
//  Discover-Photo
//
//  Created by ERU on 2019/05/28.
//  Copyright © 2019 HackingGate. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HomeCollectionViewController: UICollectionViewController {
    
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
        
        if let layout = collectionViewLayout as? WaterfallLayout {
            layout.delegate = self
            layout.numberOfColumns = 2
        } else {
            print("Not WaterfallLayout")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refresh()
    }
    
    // MARK: - Data
    
    func refresh() {
        guard photos.isEmpty else { return }
        fetchNextItems()
    }
    
    func fetchNextItems() {
        print("Fetching page \(nextPage)")
        Alamofire.request(UnsplashRequest.Router.photos(page: nextPage, perPage: UnsplashRequest.Router.perPage)).responseUnsplashPhotos { response in
            if let unsplashPhotos = response.result.value {
                self.photos += unsplashPhotos
            } else if let error = response.error {
                print("error -> \(error)")
            }
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

// MARK: UICollectionViewDataSource
extension HomeCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath)
        
        let photo = photos[indexPath.item]
        
        if let photoCell = cell as? PhotoCollectionViewCell {
            
            Alamofire.request(photo.urls.small).responseImage { response in
                if let image = response.result.value {
                    photoCell.photoView.image = image
                }
            }
            
            photoCell.photoLabel.text = String(indexPath.item)
        }
        
        return cell
    }
}

extension HomeCollectionViewController: WaterfallLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        let photo = photos[indexPath.item]
        let photoRatio = CGFloat(photo.height) / CGFloat(photo.width)
        let cellWidth = collectionView.bounds.width / 2
        let height = photoRatio * cellWidth
        return height
    }
    
}

// MARK: - UICollectionViewDelegate
extension HomeCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let prefetchCount = 19
        if indexPath.item == photos.count - prefetchCount {
            fetchNextItems()
            print("indexPath.item == \(indexPath.item), photos.count == \(photos.count), adding")
        } else {
            print("indexPath.item == \(indexPath.item), photos.count == \(photos.count), not adding")
        }
    }
    
}
