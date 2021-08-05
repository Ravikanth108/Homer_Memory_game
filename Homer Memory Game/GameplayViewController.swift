//
//  GameplayViewController.swift
//  Homer Memory Game
//
//  Created by ravikanth bollam on 2021-07-26.
//

import UIKit

class GameplayViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var gameCollectionView: UICollectionView!
    
    @IBOutlet weak var messageLbl: UILabel!
    
    var model : CardData? = nil
    var layout : GamePlayCollectionViewFlowLayout?
    let reuseIdentifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        messageLbl.text = ""
        self.layout = GamePlayCollectionViewFlowLayout()
        self.layout?.setNumColumns(gameSize: (self.model?.selectGameSize)!)
        gameCollectionView.collectionViewLayout = self.layout!

    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.model?.userCardDeck.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! GameplayCollectionViewCell
       
        switch self.model?.selectGameSize.rawValue {
            case GameSize.ThreeByFour.rawValue?:
                cell.frontImageName = (self.model?.userCardDeck[indexPath.item]?.frontImageName)!
            case GameSize.FiveByTwo.rawValue?:
                cell.frontImageName = (self.model?.userCardDeck[indexPath.item]?.frontImageName)!
        case GameSize.FourByFour.rawValue?:
            cell.frontImageName = (self.model?.userCardDeck[indexPath.item]?.frontImageName)!
            default:
                cell.frontImageName = (self.model?.userCardDeck[indexPath.item]?.frontImageName)!
        }
        cell.imageView?.image = UIImage(named: (self.model?.userCardDeck[indexPath.item]?.backImageName)!)
        cell.didFlip = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! GameplayCollectionViewCell
        
        if ( (self.model?.numFlippedCards)! > 1 || (self.model?.matchedCardIndexPathes.contains(indexPath))! ) {
            return
        }
        else if ( self.model?.numFlippedCards == 0 ) {
            cell.flipCard()
            self.model?.indexPaths.append(indexPath)
            self.model?.flipCheckIndexes.append(indexPath.item)
            self.model?.numFlippedCards+=1
        }
        else if ( self.model?.numFlippedCards == 1 ) {
            self.model?.numFlippedCards+=1
            self.model?.indexPaths.append(indexPath)
            self.model?.flipCheckIndexes.append(indexPath.item)
            cell.flipCard()
            checkCards()
            self.model?.indexPaths.removeAll(keepingCapacity: true)
        }
        else {
            return
        }
    }
    
    func checkCards () {
        if ( self.model?.userCardDeck[(self.model?.flipCheckIndexes[0])!]?.frontImageName == self.model?.userCardDeck[(self.model?.flipCheckIndexes[1])!]?.frontImageName){

            self.updateLabel(text: "You found a match.")
            
            for indexPath in (self.model?.indexPaths)!{
                self.model?.matchedCardIndexPathes.append(indexPath)
            }
            self.model?.numMatchedPairs+=1
            self.model?.numFlippedCards = 0
            self.model?.flipCheckIndexes.removeAll(keepingCapacity: true)
            checkForWin()
            
        }
 
        else {
            self.updateLabel(text: "  ")
            delayedFlip(indexPath: (self.model?.indexPaths[0])!)
            delayedFlip(indexPath: (self.model?.indexPaths[1])!)
        }
    }
    
    func delayedFlip (indexPath: IndexPath) {
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            let cell = self.gameCollectionView.cellForItem(at: indexPath) as! GameplayCollectionViewCell
            cell.flipCard()
            
            self.model?.numFlippedCards = 0
            self.model?.flipCheckIndexes.removeAll(keepingCapacity: true)
        }
    }
    
    func updateLabel(text: String){
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {self.messageLbl.alpha = 0.0 }, completion: {
            (finished: Bool) -> Void in
            self.messageLbl.text = text
        
            UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                let tempVal : CGFloat = 1.0
                    self.messageLbl.alpha = tempVal
                }, completion: nil)
        })
    }
    
    func setUpGameBoard() {
        messageLbl.text = model?.selectGameSize.rawValue
        self.layout = GamePlayCollectionViewFlowLayout()
        self.layout?.setNumColumns(gameSize: (self.model?.selectGameSize)!)
        gameCollectionView.collectionViewLayout = self.layout!
        self.model?.userCardDeck.shuffle()
        gameCollectionView.reloadData()
        self.messageLbl.text = ""
        self.model?.numMatchedPairs = 0
        self.model?.flipCheckIndexes.removeAll()
        self.model?.numFlippedCards = 0
        self.model?.matchedCardIndexPathes.removeAll()
        
    }

    func checkForWin () {
        if ( self.model?.pairsToWin == self.model?.numMatchedPairs ){
            let alert = UIAlertController.init(title: "Congratulations!", message: "You matched all the cards.", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { action in self.setUpGameBoard() }))
            self.present(alert, animated: true, completion:nil)
        }
    }
  
}
