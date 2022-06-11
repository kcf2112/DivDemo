//
//  Quote.swift
//  DivDemo
//
//  Created by Kevin Filer on 3/13/22.
//

import Foundation

/*
 Represents an end-of-day equity price quote
 */
struct Quote: Codable {
    var symbol: String
    var open: Double = 0.0
    var high: Double = 0.0
    var low: Double = 0.0
    var price: Double = 0.0
    var change: Double = 0.0
    var changePercent: Double = 0.0
    var timestamp: Int = 0
    
    // If this enum is present, ONLY these fields will
    // be decoded.  The enum must contain all needed fields.
    // FMP version:
    private enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case open = "open"
        case high = "dayHigh"
        case low = "dayLow"
        case price = "price"
        case change = "change"
        case changePercent = "changesPercentage"
        case timestamp = "timestamp"
    }
    
    init( symbol: String ) {
        self.symbol = symbol
    }
}

extension Quote: Identifiable {
    var id: UUID {
        return UUID()
    }
    
    var formattedQuoteDate: String {
        //let epochTime = TimeInterval( timestamp )
        let date = Date( timeIntervalSince1970: TimeInterval( timestamp ) )
        return date.formatted( date: .abbreviated, time: .omitted )
    }
}
