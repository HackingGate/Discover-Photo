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

class HomeCollectionViewController: BaseCollectionViewController {
    
    /// Search bar.
    private var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupSearch()
        _setupRefreshControl()
        refresh()
    }
    
    // MARK: - Data
    
    @objc func refresh() {
        fetch(clean: true, searchBar: searchBar)
    }
    
    func fetch(clean: Bool, searchBar: UISearchBar?) {
        if clean {
            photos.removeAll()
        }
        if let searchText = searchBar?.text, searchText.count > 0 {
            fetchNextItems(query: searchText)
        } else {
            fetchNextItems()
        }
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
        searchBar.placeholder = "Search photos"
        // Place the search bar in the navigation bar.
        navigationItem.titleView = searchBar
    }
    
    // MARK: - Refresh Control
    
    private func _setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
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
        
        if photos.count > indexPath.item {
            let photo = photos[indexPath.item]
            configureCell(cell, photo: photo, indexPath: indexPath)
        } else {
            print("warning: array photos no \(indexPath.item)")
        }
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension HomeCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let prefetchCount = 19
        if indexPath.item == photos.count - prefetchCount {
            fetch(clean: false, searchBar: searchBar)
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = nil
        fetch(clean: true, searchBar: searchBar)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        fetch(clean: true, searchBar: searchBar)
    }
    
}

extension HomeCollectionViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoCellSelected" {
            if let photoTableVC = segue.destination as? PhotoTableViewController,
                let cell = sender as? PhotoCollectionViewCell,
                let indexPath = self.collectionView.indexPath(for: cell) {
                let unsplashPhoto = self.photos[indexPath.item]
                photoTableVC.photo = unsplashPhoto
            }
        }
    }
    
}
