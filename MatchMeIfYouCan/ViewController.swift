//
//  ViewController.swift
//  MatchMeIfYouCan
//
//  Created by Koramit Pichanaharee on 21/10/18.
//  Copyright © 2018 Lullabears. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // v 0.2
    // lazy var cannot have observer
    lazy var game = MatchMeIfYouCan(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    // v 0.2
    
    // Class 'ViewController' has no initializers
    // var flipCount: Int
    
    // swift is extremry strong type
    // var flipCount: Int = 0
    
    // but switf can inferred
    var flipCount = 0 {
        // property observer pattern
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    // @IBAction xcode auto add this directive
    // func => function
    // Names of argument (internal+external names)
//    @IBAction func touchCard(_ sender: UIButton) {
//        flipCount += 1
//        flipCard(withEmoji: "🐻", on: sender)
//    }
//
//    @IBAction func touchSecondCard(_ sender: UIButton) {
//        flipCount += 1
//        flipCard(withEmoji: "🙉", on: sender)
//    }
    
    // array always return optional data [set] or [not set]
    // nil = not set case of optional
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoicesTemplate = ["🐻", "🐨", "🐷", "👩🏻", "🙉", "🐦", "🐶", "🐼", "🐛", "🐚", "🍟", "🍕", "🍱", "🥘", "🍉", "🍎","🌸", "😜", "👵🏻", "👴🏻", "🍄", "🍡", "🌈", "🍻"]
    lazy var emojiChoices = emojiChoicesTemplate
    
    // v0.2
    // var emoji = Dictionary<Int, String>()
    var emoji = [Int:String]()
    // v0.2
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        // add ! at the end of 'cardButtons.firstIndex(of: sender)'
        // to assume that cardButtons is initiated
        // but will crash in case of nil
        // so we can use if for exception handle.
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            // flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            // let game handle instead of fliCard()
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("card not in the array")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
            } else {
                button.setTitle(card.isMatched ? "":"🎃", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    // names order => external internal
    // name = _ => no external name for Objective c interoperable
    // if declare only one name => external and internal use the same name
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        // print("flipCard(withEmoji: \(emoji))")
        if button.currentTitle == emoji {
            button.setTitle("🎃", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
        }
    }
    
    
    @IBAction func newGame(_ sender: UIButton) {
        flipCount = 0
        emojiChoices = emojiChoicesTemplate
        game = MatchMeIfYouCan(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        for button in cardButtons {
            button.setTitle("🎃", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}

