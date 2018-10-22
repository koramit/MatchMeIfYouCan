//
//  Card.swift
//  MatchMeIfYouCan
//
//  Created by Koramit Pichanaharee on 21/10/18.
//  Copyright © 2018 Lullabears. All rights reserved.
//

import Foundation

// major differents struct vs class
// struct no inheritance
// struct is a value type not a reference type
// Swift use copy on write semantic
struct Card
{
    var isFaceUp = false
    var isMatched = false
    // Card is UI independent so we not store emoji
    var identifier: Int
    
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
//    init(identifier: Int) {
//        self.identifier = identifier
//    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
 
