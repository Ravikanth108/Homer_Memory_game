//
//  LobbyViewController.swift
//  Homer Memory Game
//
//  Created by ravikanth bollam on 2021-07-26.
//

import UIKit

enum GameSize : String {
    
    case ThreeByFour
    case FiveByTwo
    case FourByFour
    case FourByFive
}

class LobbyViewController: UIViewController {
    
    
    @IBOutlet weak var grid12Btn: UIButton!
    @IBOutlet weak var grid10Btn: UIButton!
    @IBOutlet weak var grid16Btn: UIButton!
    @IBOutlet weak var grid20Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gridSize = GridSize()
        
        grid10Btn.layer.cornerRadius = 10
        grid10Btn.clipsToBounds = true
        grid12Btn.layer.cornerRadius = 10
        grid12Btn.clipsToBounds = true
        grid16Btn.layer.cornerRadius = 10
        grid16Btn.clipsToBounds = true
        grid20Btn.layer.cornerRadius = 10
        grid20Btn.clipsToBounds = true
        
    }
    
    var gridSize: GridSize?
    
    @IBAction func grid12BtnClicked(_ sender: Any) {
        grid10Btn.isEnabled = false
        grid16Btn.isEnabled = false
        grid20Btn.isEnabled = false
        gridSize?.selectGridSize = GameSize.ThreeByFour
        self.performSegue(withIdentifier: "ShowGameView", sender: self)
    }
    
    @IBAction func grid10BtnClicked(_ sender: Any) {
        grid12Btn.isEnabled = false
        grid16Btn.isEnabled = false
        grid20Btn.isEnabled = false
        gridSize?.selectGridSize = GameSize.FiveByTwo
        self.performSegue(withIdentifier: "ShowGameView", sender: self)
    }
    
    @IBAction func grid16BtnClicked(_ sender: Any) {
        grid10Btn.isEnabled = false
        grid12Btn.isEnabled = false
        grid20Btn.isEnabled = false
        gridSize?.selectGridSize = GameSize.FourByFour
        self.performSegue(withIdentifier: "ShowGameView", sender: self)
    }
    
    @IBAction func grid20BtnClicked(_ sender: Any) {
        grid10Btn.isEnabled = false
        grid16Btn.isEnabled = false
        grid12Btn.isEnabled = false
        gridSize?.selectGridSize = GameSize.FourByFive
        self.performSegue(withIdentifier: "ShowGameView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  Enable the buttons before transitioning.    //
        grid10Btn.isEnabled = true
        grid16Btn.isEnabled = true
        grid12Btn.isEnabled = true
        grid20Btn.isEnabled = true
        
        if segue.identifier == "ShowGameView" {
            if let destination = segue.destination as? GameplayViewController {
                let gameSize : GameSize = gridSize!.selectGridSize!
                let cardData = CardData(gameSize: gameSize)
                destination.model = cardData
            }
        }
    }
    
}
