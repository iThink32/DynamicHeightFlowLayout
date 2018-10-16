//
//  ViewController.swift
//  FeedLayout
//
//  Created by N.A Shashank on 15/10/18.
 
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,DynamicHeightFlowLayoutDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrDataSource = [DetailItemModel(title: "A", backgroundColor: UIColor.red,cellHeight:200),DetailItemModel(title: "B", backgroundColor: UIColor.blue,cellHeight:400),DetailItemModel(title: "C", backgroundColor: UIColor.green,cellHeight:250),DetailItemModel(title: "D", backgroundColor: UIColor.purple,cellHeight:340),DetailItemModel(title: "E", backgroundColor: UIColor.orange,cellHeight:420),DetailItemModel(title: "F", backgroundColor: UIColor.magenta,cellHeight:140)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let feedLayout = self.collectionView.collectionViewLayout as? DynamicHeightFlowLayout else{
            assertionFailure("could not get feed layout")
            return
        }
        feedLayout.delegate = self
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
        return self.arrDataSource[indexPath.item].cellHeight
    }


}

