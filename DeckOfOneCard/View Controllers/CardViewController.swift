//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Benjamin Tincher on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    var deckID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DeckController.createNewDeck(quantityOfDecks: 1) { (result) in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let deck):
                    self.deckID = deck.deck_id
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    @IBAction func drawButtonTapped(_ sender: Any) {
        guard let deckID = deckID else { return }
        CardController.fetchCards(quantityOfCards: 1, deckID: deckID) { (result) in
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let cards):
                    self.fetchCardAndUpdateViews(cards: cards)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
            
        }
    }
    
    func fetchCardAndUpdateViews(cards: [Card]) {
        guard let card = cards.first else { return }
        cardLabel.text = "\(card.value) of \(card.suit)"
        
        do {
            let imageData = try Data(contentsOf: card.image)
            guard let image = UIImage(data: imageData) else { return }
            self.cardImageView.image = image
        } catch {
            print("======== ERROR ========")
            print("Function: \(#function)")
            print("Error: \(error)")
            print("Description: \(error.localizedDescription)")
            print("======== ERROR ========")
            return
        }
    }
    
}
