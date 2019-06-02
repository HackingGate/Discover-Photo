//
//  PhotoTableViewController.swift
//  Discover-Photo
//
//  Created by ERU on 2019/06/02.
//  Copyright © 2019 HackingGate. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoTableViewController: UITableViewController {

    var photo: UnsplashPhoto!
    
    private var tableViewWidth: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return tableView.bounds.width - tableView.safeAreaInsets.left - tableView.safeAreaInsets.right
            } else {
               return tableView.bounds.width
            }
        }
    }
    
    @IBOutlet weak var photoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setupPhoto()
    }
    
    func _setupPhoto() {
        if let hexColorString = photo.color {
            photoView.backgroundColor = UIColor.hexStringToUIColor(hex: hexColorString)
        }
        Alamofire.request(photo.urls.full).responseImage { response in
            if let image = response.result.value {
                self.photoView.image = image
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return tableViewWidth / CGFloat(photo.width) * CGFloat(photo.height)
        }
        return CGFloat.leastNormalMagnitude
    }
    
}
