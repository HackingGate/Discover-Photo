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

class HomeCollectionViewController: BasicCollectionViewController {
    
    /// Search bar.
    private var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupSearch()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let layout = collectionViewLayout as? WaterfallLayout {
            layout.delegate = self
            layout.numberOfColumns = 2
        } else {
            print("Not WaterfallLayout")
        }
        
        refresh()
    }
    
    // MARK: - Data
    
    func refresh() {
        guard photos.isEmpty else { return }
        fetchNextItems()
    }
    
    func fetchNextItems() {
        print("Fetching page \(nextPage)")
        let request = UnsplashRequest.Router.photos(page: nextPage,
                                                    perPage: UnsplashRequest.Router.perPage)
        Alamofire.request(request).responseUnsplashPhotos { response in
            if let unsplashPhotos = response.result.value {
                self.photos += unsplashPhotos
                self.reloadData()
            } else if let error = response.error {
                print("error -> \(error)")
            }
        }
    }
    
    func fetchNextItems(query: String) {
        print("Fetching page \(nextPage) with query: \(query)")
        let request = UnsplashRequest.Router.searchPhotos(query: query,
                                                          page: nextPage,
                                                          perPage: UnsplashRequest.Router.perPage)
        Alamofire.request(request).responseUnsplashSearch { response in
            if let unsplashSearch = response.result.value {
                
                self.photos += unsplashSearch.results
                self.reloadData()
            } else if let error = response.error {
                print("error -> \(error)")
            }
        }
    }
    
    // MARK: - Search
    
    private func _setupSearch() {
        searchBar.delegate = self
        // Place the search bar in the navigation bar.
        navigationItem.titleView = searchBar
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
        
        configureCell(cell, photo: photo, indexPath: indexPath)
        
        return cell
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

// MARK: - UISearchBarDelegate
extension HomeCollectionViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text, searchText.count > 0 {
            photos = UnsplashPhotos()
            fetchNextItems(query: searchText)
        }
    }
    
}
