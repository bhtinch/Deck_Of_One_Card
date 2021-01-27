//
//  DeckController.swift
//  DeckOfOneCard
//
//  Created by Benjamin Tincher on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

class DeckController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api")
    static let deckEndpoint = "deck"
    static let newShuffledDeckEnpoint = "new/shuffle/"
    
    static func createNewDeck(quantityOfDecks: Int, completion: @escaping (Result<Deck, LocalError>) -> Void){
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        let deckURL = baseURL.appendingPathComponent(deckEndpoint)
        let newShuffledDeckURL = deckURL.appendingPathComponent(newShuffledDeckEnpoint)
        var components = URLComponents(url: newShuffledDeckURL, resolvingAgainstBaseURL: true)
        
        let deckQuantityString = String(quantityOfDecks)
        let deckCountQuery = URLQueryItem(name: "deck_count", value: deckQuantityString)
        components?.queryItems = [deckCountQuery]
        
        guard let finalURL = components?.url else { return }
        
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let deck = try JSONDecoder().decode(Deck.self, from: data)
                completion(.success(deck))
            } catch {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
}
