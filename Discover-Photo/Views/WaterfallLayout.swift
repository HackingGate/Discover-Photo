//
//  WaterfallLayout.swift
//  Discover-Photo
//
//  Created by ERU on 2019/05/29.
//  Copyright © 2019 HackingGate. All rights reserved.
//

import UIKit

protocol WaterfallLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
    
}

class WaterfallLayout: UICollectionViewLayout {
    
    var delegate: WaterfallLayoutDelegate!
    var numberOfColumns = 1
    
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
        for itemIndex in 0..<collectionView!.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: itemIndex, section: 0)
            let itemHeight = delegate.collectionView(collectionView: collectionView!,
                                                 heightForItemAtIndexPath: indexPath)
            let frame = CGRect(x: xOffsets[column],
                               y: yOffsets[column],
                               width: columnWidth,
                               height: itemHeight)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            attributesCache.append(attributes)
            contentHeight = max(contentHeight, frame.maxY)
            yOffsets[column] = yOffsets[column] + itemHeight
            column = column >= (numberOfColumns - 1) ? 0 : column+1
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
