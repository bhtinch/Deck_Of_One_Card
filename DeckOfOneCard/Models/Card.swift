//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Benjamin Tincher on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

struct Card: Codable {
    let value: String
    let suit: String
    let image: URL
}

struct TopLevelObject: Codable {
    let cards: [Card]
}
