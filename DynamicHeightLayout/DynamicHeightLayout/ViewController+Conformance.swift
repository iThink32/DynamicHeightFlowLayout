//
//  ViewController+Conformance.swift
//  DynamicHeightLayout
//
//  Created by N.A Shashank on 23/10/18.

//

import UIKit

extension ViewController:UICollectionViewDropDelegate,UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let reqdItem = self.arrDataSource[indexPath.item]
        let itemProvider = NSItemProvider(object:reqdItem)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = reqdItem
        return [dragItem]
    }

    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        let reqdItem = self.arrDataSource[indexPath.item]
        let itemProvider = NSItemProvider(object:reqdItem)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = reqdItem
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        guard session.localDragSession != nil else{
            return UICollectionViewDropProposal(operation: UIDropOperation.forbidden)
        }
        return UICollectionViewDropProposal(operation: UIDropOperation.move, intent: UICollectionViewDropProposal.Intent.insertAtDestinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let indexPathDestination = coordinator.destinationIndexPath ?? IndexPath(item: collectionView.numberOfItems(inSection: 0) - 1, section: 0)
        switch coordinator.proposal.operation {
        case UIDropOperation.copy :
            collectionView.performBatchUpdates({
                var arrIndexPaths = [IndexPath]()
                for (index,item) in coordinator.items.enumerated()  {
                  let destIndexPath = IndexPath(item: indexPathDestination.item + index, section: 0)
                    guard let dataSource = item.dragItem.localObject as? DetailItemModel else{
                        continue
                    }
                  self.arrDataSource.insert(dataSource, at: destIndexPath.item)
                  arrIndexPaths.append(destIndexPath)
                }
                collectionView.reloadItems(at: arrIndexPaths)
                }, completion: nil)
        case UIDropOperation.forbidden, UIDropOperation.cancel :
            print("no handler for this case")
        case UIDropOperation.move :
            guard let itemToDrop = coordinator.items.first,let dataModel = itemToDrop.dragItem.localObject as? DetailItemModel,let sourceIndexPath = itemToDrop.sourceIndexPath else{
                break
            }
            let indexPath = IndexPath(item: collectionView.numberOfItems(inSection: 0) - 1, section: 0)
            let destIndexPath = indexPathDestination.item > collectionView.numberOfItems(inSection: 0) - 1 ? indexPath : indexPathDestination
            collectionView.performBatchUpdates({
                self.arrDataSource.remove(at: sourceIndexPath.item)
                self.arrDataSource.insert(dataModel, at: destIndexPath.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destIndexPath])
            }, completion: nil)
            coordinator.drop(itemToDrop.dragItem, toItemAt: destIndexPath)
        }
        
    }
    
}
