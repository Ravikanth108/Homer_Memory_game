//
//  CardData.swift
//  Homer Memory Game
//
//  Created by ravikanth bollam on 2021-07-26.
//

import Foundation

class CardData {
    
    var imageNameArray : [String] = ["1.png", "2.png", "3.png", "4.png", "5.png", "6.png", "7.png", "8.png", "9.png", "10.png"]
    
    func randomPick(i: Int) -> [String]  {

        var resultSet = Set<String>()

        while resultSet.count < i {
            let randomIndex = Int(arc4random_uniform(UInt32(imageNameArray.count)))
            resultSet.insert(self.imageNameArray[randomIndex])
        }

        let resultArray = Array(resultSet)
        let repeatArray = Array(repeating: resultArray, count: 2)
        let result = Array(repeatArray.joined())

        return result

    }
        
    lazy var grid12Data : [String] = randomPick(i: 6)
    lazy var grid10Data : [String] = randomPick(i: 5)
    lazy var grid16Data : [String] = randomPick(i: 8)
    lazy var grid20Data : [String] = randomPick(i: 10)
    
    var selectGameSize : GameSize 
    var pairsToWin : Int = 0
    var userCardDeck : [CardDeck?]
   
    var matchedCardIndexPathes = [IndexPath]()
    var flipCheckIndexes = [Int]()
    var numFlippedCards = 0
    var numMatchedPairs = 0
    var indexPaths = [IndexPath]()
    
    init(gameSize: GameSize){
        self.selectGameSize = gameSize
        self.userCardDeck = []
        populateCardDeck()
        self.userCardDeck.shuffle()
        setPairsToWin()
    }
  
     func populateCardDeck () {
    
        if (self.selectGameSize == GameSize.ThreeByFour){
            for index in 0...11 {
                let selectCard : CardDeck = CardDeck()
                selectCard.frontImageName = grid12Data[index]
                userCardDeck.append(selectCard)
            }
        }
        else if (self.selectGameSize == GameSize.FiveByTwo){
            for index in 0...9 {
                let selectCard : CardDeck = CardDeck()
                selectCard.frontImageName = grid10Data[index]
                userCardDeck.append(selectCard)
            }
            
        }
        else if (self.selectGameSize == GameSize.FourByFour){
            for index in 0...15 {
                let selectCard : CardDeck = CardDeck()
                selectCard.frontImageName = grid16Data[index]
                userCardDeck.append(selectCard)
            }
        }
        else {
            for index in 0...19 {
                let selectCard : CardDeck = CardDeck()
                selectCard.frontImageName = grid20Data[index]
                userCardDeck.append(selectCard)
            }
        }

    }
    
     func setPairsToWin() {
        switch self.selectGameSize {
        case .ThreeByFour :
            pairsToWin = 6
        case .FiveByTwo :
            pairsToWin = 5
        case .FourByFour :
            pairsToWin = 8
        default :
            pairsToWin = 10
        }
    }
   
}

//extension Array
//{
//    mutating func shuffle()
//    {
//        for _ in 0..<20
//        {
//            sort { (_,_) in arc4random() < arc4random() }
//        }
//    }
//}

