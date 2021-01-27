//
//  LocalError.swift
//  DeckOfOneCard
//
//  Created by Benjamin Tincher on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

enum LocalError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecodeJSON
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Unable to reach server."
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server returned no data."
        case .unableToDecodeJSON:
            return "Unable to load image."
        }
    }
}
