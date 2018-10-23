//
//  ViewController.swift
//  FeedLayout
//
//  Created by N.A Shashank on 15/10/18.
 
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,DynamicHeightFlowLayoutDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrDataSource = [DetailItemModel(title: "A"),DetailItemModel(title: "B"),DetailItemModel(title: "C"),DetailItemModel(title: "D"),DetailItemModel(title: "E"),DetailItemModel(title: "F")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let feedLayout = self.collectionView.collectionViewLayout as? DynamicHeightFlowLayout else{
            assertionFailure("could not get feed layout")
            return
        }
        feedLayout.delegate = self
        collectionView.dragInteractionEnabled = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let detailItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailItemCell", for: indexPath) as! DetailItemCell
        detailItemCell.setData(dataSource: self.arrDataSource[indexPath.row])
        return detailItemCell
    }
    
    func heightForItem(at indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 0
        switch indexPath.item {
        case 0 :
            height = 170
        case 1 :
            height = 150
        case 2 :
            height = 179
        case 3 :
            height = 350
        case 4 :
            height = 379
        case 5 :
            height = 300
        case 6 :
            height = 192
        default :
            height = 100
        }
        return height
    }



}

