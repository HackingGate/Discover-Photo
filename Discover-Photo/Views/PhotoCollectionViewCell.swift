//
//  PhotoCollectionViewCell.swift
//  Discover-Photo
//
//  Created by ERU on 2019/05/29.
//  Copyright © 2019 HackingGate. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PhotoCell"

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var textLabel: UILabel!
    
    func configure(photo: UnsplashPhoto, cornerRadius: CGFloat) {
        photoView.layer.cornerRadius = cornerRadius
        if let hexColorString = photo.color {
            photoView.backgroundColor = UIColor.hexStringToUIColor(hex: hexColorString)
        }
        Alamofire.request(photo.urls.thumb).responseImage { response in
            if let image = response.result.value {
                let roundedImage = image.af_imageScaled(to: self.photoView.bounds.size)
                let gradientLayer = CAGradientLayer()
                gradientLayer.frame = self.blurView.bounds
                gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
                gradientLayer.locations = [0.6180339887, 1.0] // Golden ratio
                gradientLayer.cornerRadius = cornerRadius
                self.blurView.layer.mask = gradientLayer
                self.photoView.image = roundedImage
            }
        }
        textLabel.text = photo.user.username
    }
}
