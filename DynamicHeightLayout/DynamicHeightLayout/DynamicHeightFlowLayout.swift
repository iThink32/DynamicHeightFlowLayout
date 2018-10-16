//
//  FeedFlowLayout.swift
//  FeedLayout
//
//  Created by N.A Shashank on 15/10/18.
//  Copyright © 2018 Razorpay. All rights reserved.
//

import UIKit

protocol DynamicHeightFlowLayoutDelegate:class {
    func heightForItem(at indexPath:IndexPath) -> CGFloat
}

class DynamicHeightFlowLayout: UICollectionViewFlowLayout {
    weak var delegate:DynamicHeightFlowLayoutDelegate?
    
    private var arrLayoutAttributes = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight:CGFloat = 0
    
    private var contentWidth:CGFloat {
        guard let collectionView = collectionView else{
            return 0.0
        }
        return collectionView.frame.size.width - (self.sectionInset.left + self.sectionInset.right)
    }
    
    @IBInspectable var noOfColumns:Int = 2
    
    @IBInspectable var padding:CGFloat = 20.0
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = self.collectionView,let delegate = self.delegate else{
            assertionFailure("could not get collectionview")
            return
        }
        self.arrLayoutAttributes.removeAll()
        var arrXOffsets = [CGFloat](repeating: 0, count: self.noOfColumns)
        var arrYOffsets = [CGFloat](repeating: 0, count: noOfColumns)
        // calculate number of columns based on padding
        // no of padding cells = number of columns - 1
        let noOfPaddingCells = self.noOfColumns - 1
        let totalPaddingWidth:CGFloat = CGFloat(noOfPaddingCells) * self.padding
        let itemWidth:CGFloat = (self.contentWidth - totalPaddingWidth)  / CGFloat(self.noOfColumns)
        // assign first value acc to insets
        arrXOffsets[0] = self.sectionInset.left
        arrYOffsets[0] = self.sectionInset.top
        // compute the rest respectively
        for i in 1..<noOfColumns {
            // next item position = prev item position + item width + padding
            arrXOffsets[i] = arrXOffsets[i-1] + itemWidth + self.padding
            // first item of all columns must begin at postion = sectionInset.top
            arrYOffsets[i] = self.sectionInset.top
        }
        var column = 0
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let cellHeight = delegate.heightForItem(at: indexPath)
            let frame = CGRect(x: arrXOffsets[column], y: arrYOffsets[column], width: itemWidth, height: cellHeight)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            self.arrLayoutAttributes.append(attributes)
            // add vertical padding only if it is not the last cell
//            let verticalPadding = (indexPath.item == collectionView.numberOfItems(inSection: 0) - 1) ? 0 : self.padding
            self.contentHeight = max(self.contentHeight, frame.maxY + self.padding)
            arrYOffsets[column] = arrYOffsets[column] + cellHeight + self.padding
            column = (column + 1) %  noOfColumns
            // add bottom inset to contentHeight after the last item
            //self.contentHeight = self.contentHeight + self.sectionInset.bottom
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var arrViewLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in self.arrLayoutAttributes where attributes.frame.intersects(rect) {
            arrViewLayoutAttributes.append(attributes)
        }
        return arrViewLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.arrLayoutAttributes[indexPath.item]
    }
    
    

}
