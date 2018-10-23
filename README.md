# DynamicHeightFlowLayout


## What does it do ?
This project contains a simple flow layout class that allows you to fill the screen with cells of varying height in multiple
columns.

All you have to do is set the class in the flow layout section of the collectionview ,number of columns and the padding
in the IBInspector, required section insets and your good to go.

In my project i have set a top/left/bottom/right section inset of 20 and a padding of 20.

Oh ya , one more thing implement the DynamicHeightFlowLayoutDelegate as so

```
        guard let feedLayout = self.collectionView.collectionViewLayout as? DynamicHeightFlowLayout else{
            assertionFailure("could not get feed layout")
            return
        }
        feedLayout.delegate = self
```

and then provide the height for each item in the method

```
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
``` 
### Note :
This repo also contains the drag-drop feature for UICollectionView , have a look at the implementation if needed.

### Gif time :

![alt text](https://github.com/iThink32/DynamicHeightFlowLayout/blob/master/DynamicHeightFlowLayout.gif)


