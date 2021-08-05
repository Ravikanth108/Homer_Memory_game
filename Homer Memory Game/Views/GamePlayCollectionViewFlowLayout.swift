//
//  GamePlayCollectionViewFlowLayout.swift
//  Homer Memory Game
//
//  Created by ravikanth bollam on 2021-07-26.
//

import UIKit

class GamePlayCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setupLayout()
    }
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
   
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 10
    }
    
    var numColumns : CGFloat = 4
    
    func setNumColumns(gameSize: GameSize){
        if(gameSize == GameSize.ThreeByFour){
            numColumns = 3
        }
        else if(gameSize == GameSize.FiveByTwo){
            numColumns = 5
        }
        else if(gameSize == GameSize.FourByFour){
            numColumns = 4
        }
        else {
            numColumns = 4
        }
    }
    
    override var itemSize: CGSize {

        set {
            
        }
        get {
            let numberOfColumns: CGFloat = numColumns
            
            let itemWidth = (self.collectionView!.frame.width - (numberOfColumns)) / numberOfColumns
      
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
}
