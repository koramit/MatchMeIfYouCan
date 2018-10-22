//
//  MatchMeIfYouCan.swift
//  MatchMeIfYouCan
//
//  Created by Koramit Pichanaharee on 21/10/18.
//  Copyright © 2018 Lullabears. All rights reserved.
//

import Foundation

class MatchMeIfYouCan
{
    var cards = [Card]() // empty array of Card
    var indexOfOneAndOnlyFaceUpCard: Int?
    func chooseCard(at index: Int) {
        // test code
//        if cards[index].isFaceUp {
//            cards[index].isFaceUp = false
//        } else {
//            cards[index].isFaceUp = true
//        }
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    print("cards match")
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
//        for identifier in 1...numberOfPairsOfCards {
//            let card = Card(identifier: identifier)
//            cards += [card, card]
//
//            // let matchingCard = card
//            // cards.append(card)
//            // cards.append(matchingCard)
//        }
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: shuffle the cards
        cards = cards.shuffled()
    }
}
