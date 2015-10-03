//
//  SlapAttachViewController.swift
//  SlapAttack
//
//  Created by Matthew Curtner on 9/30/15.
//  Copyright © 2015 Matthew Curtner. All rights reserved.
//

import UIKit

class SlapAttachViewController: UIViewController {
    
    @IBOutlet weak var player1Desk: UIImageView!
    @IBOutlet weak var player2Deck: UIImageView!
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    @IBOutlet weak var bottomCenterCard: UIImageView!
    @IBOutlet weak var topCenterCard: UIImageView!

    var allCardsArray = [String]()
    var centerCardsArray = [String]()
    var centerCardsAreSame: Bool = false
    
    var isPlayer1Turn: Bool = true
    var isPlayer2Turn: Bool = false
    var playerBuzzed: Bool = false
    
    var player1Score: Int = 0
    var player2Score: Int = 0
    
    var cardString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add the cards to the arra5
        addCardsToArray(letter1: "H", letter2: "C", letter3: "D", letter4: "S")
    }
    
    
    // MARK: - Game Logic
    
    //Load all cards into an Array based on card number

    func addCardsToArray(letter1 letter1:String, letter2: String, letter3: String, letter4: String) {
        
        // Add all card names 2 though 15 into array
        for index in 2...14 {
            self.allCardsArray.append("\(index)_\(letter1)")
            self.allCardsArray.append("\(index)_\(letter2)")
            self.allCardsArray.append("\(index)_\(letter3)")
            self.allCardsArray.append("\(index)_\(letter4)")
        }
        
        print(allCardsArray.count)
    }
    
    // Remove all non-numerical characters from string
    
    func getNumbersFromString(theString theString: String) -> Int {
        
        var strVal = theString
        strVal = strVal.stringByReplacingOccurrencesOfString(
            "\\D", withString: "", options: .RegularExpressionSearch,
            range: strVal.startIndex..<strVal.endIndex)
        
        return Int(strVal)!
    }
    
    // Check if center cards are the same
    
    func compareCenterCards() -> Bool {
        let topCardValue: Int = getNumbersFromString(theString: centerCardsArray[centerCardsArray.count - 1])
        let bottomCardValue: Int = getNumbersFromString(theString: centerCardsArray[centerCardsArray.count - 2])
        
        print("Topcard is: \(topCardValue), BottomCard is: \(bottomCardValue)")
        
        if topCardValue == bottomCardValue {
            print("Cards are the same")
            return true
        } else {
            print("uh oh!")
            return false
        }
    }
    
    // Get a card based on a random number
    
    func getRandomCard() {
        let randomCard = arc4random_uniform(51) + 1
        cardString = String(format: "%@", allCardsArray[Int(randomCard)])
    }
    
    // Set the bottomCenterCard image
    func setBottomCardImage() {
        if centerCardsArray.count > 1 {
            bottomCenterCard.image = UIImage(named: centerCardsArray[centerCardsArray.count - 2])
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func player1TappedCard(sender: AnyObject) {
        if isPlayer1Turn {
            getRandomCard()
            topCenterCard.image = UIImage(named: cardString!)
            //print(cardString)
            
            centerCardsArray.append(cardString!)
            
            setBottomCardImage()
            
            isPlayer2Turn = true
            isPlayer1Turn = false
        }
    }
    
    @IBAction func player2TappedCard(sender: AnyObject) {
        if isPlayer2Turn {
            getRandomCard()
            topCenterCard.image = UIImage(named: cardString!)
            
            centerCardsArray.append(cardString!)
            
            setBottomCardImage()

            
            isPlayer1Turn = true
            isPlayer2Turn = false
        }
    }
    
    @IBAction func player1Buzzed(sender: AnyObject) {
        if compareCenterCards() == true {
            player1Score += 1
            player1ScoreLabel.text = String(player1Score)
        }
    }
    
    @IBAction func player2Buzzed(sender: AnyObject) {
        if compareCenterCards() == true {
            player2Score += 1
            player2ScoreLabel.text = String(player2Score)
        }
    }
}
