//
//  GameplayCollectionViewCell.swift
//  Homer Memory Game
//
//  Created by ravikanth bollam on 2021-07-26.
//

import UIKit

class GameplayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var didFlip : Bool = true
    var backImageName: String = "allCardBacks"
    var frontImageName = ""
    
    
    func flipCard() {
        UIView.transition(  with: contentView,
                            duration:0.5,
                            options:.transitionFlipFromLeft,
                            animations: {
                                self.imageView?.image = UIImage(named: self.didFlip ? self.frontImageName : self.backImageName)
                            },
                            completion: nil)
        
        self.didFlip = !self.didFlip
    }
    
    
}
