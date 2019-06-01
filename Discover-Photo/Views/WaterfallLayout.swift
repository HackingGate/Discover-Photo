//
//  WaterfallLayout.swift
//  Discover-Photo
//
//  Created by ERU on 2019/05/29.
//  Copyright © 2019 HackingGate. All rights reserved.
//

import UIKit

protocol WaterfallLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
    
}

class WaterfallLayout: UICollectionViewLayout {
    
    var delegate: WaterfallLayoutDelegate!
    var numberOfColumns = 1
    var spacing: CGFloat = 8
    
    private var attributesCache = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var collectionViewWidth: CGFloat {
        get {
            return collectionView!.bounds.width
        }
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: collectionViewWidth, height: contentHeight)
        }
    }
    
    override func prepare() {
        let columnWidth = collectionViewWidth / CGFloat(numberOfColumns)
        var xOffsets = [CGFloat]()
        for column in 0..<numberOfColumns {
            xOffsets.append(CGFloat(column) * columnWidth)
        }
        
        var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)
        
        var column = 0
        guard let numberOfItems = collectionView?.numberOfItems(inSection: 0) else {
            return
        }
        for itemIndex in 0..<numberOfItems {
            let indexPath = IndexPath(item: itemIndex, section: 0)
            let photoSize = delegate.collectionView(collectionView: collectionView!,
                                                   sizeForItemAtIndexPath: indexPath)
            let photoRatio = photoSize.height / photoSize.width
            let itemHeight = photoRatio * columnWidth
            
            var frame = CGRect(x: xOffsets[column],
                               y: yOffsets[column],
                               width: columnWidth,
                               height: itemHeight)
            if column == 0 {
                // left edge column
                frame.origin.x = xOffsets[column] + spacing
            } else {
                frame.origin.x = xOffsets[column] + spacing / 2
            }
            frame.origin.y = yOffsets[column] + spacing
            frame.size.width = (collectionViewWidth - spacing * CGFloat(numberOfColumns + 1)) / CGFloat(numberOfColumns)
            frame.size.height = frame.size.width / photoSize.width * photoSize.height
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            attributesCache.append(attributes)
            contentHeight = max(contentHeight, frame.maxY)
            yOffsets[column] = yOffsets[column] + frame.size.height + spacing
            // Put new cell into shortest column
            if let min = yOffsets.min() {
                column = yOffsets.firstIndex(of: min) ?? 0
            } else {
                column = 0
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in attributesCache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }

}
