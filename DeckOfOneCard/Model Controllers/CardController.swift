//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Benjamin Tincher on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

class CardController {
    static let drawEndpoint = "draw/"
    
    static func fetchCards(quantityOfCards: Int, deckID: String, completion: @escaping (Result<[Card], LocalError>) -> Void) {
        
        guard let baseURL = DeckController.baseURL else { return completion(.failure(.invalidURL)) }
        
        let deckURL = baseURL.appendingPathComponent(DeckController.deckEndpoint)
        let deckIdURL = deckURL.appendingPathComponent(deckID)
        let drawCardURL = deckIdURL.appendingPathComponent(drawEndpoint)
        
        var components = URLComponents(url: drawCardURL, resolvingAgainstBaseURL: true)
        
        let cardCountString = String(quantityOfCards)
        let cardCountQuery = URLQueryItem(name: "count", value: cardCountString)
        components?.queryItems = [cardCountQuery]
        
        guard let finalURL = components?.url else { return }
        
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("======== ERROR 1 ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                completion(.success(topLevelObject.cards))
            } catch {
                print("======== ERROR 2 ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
        
    }
}
