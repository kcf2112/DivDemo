//
//  Quote.swift
//  DivDemo
//
//  Created by Kevin Filer on 3/13/22.
//

import Foundation

/*
 Represents an end-of-day equity price quote
 Alphavantage version:
    Note: Number values are given as strings.
 {
    "01. symbol": "DIVO",
    "02. open": "37.2200",
    "03. high": "37.3500",
    "04. low": "37.0900",
    "05. price": "37.3100",
    ...
    "09. change": "-0.1100",
    "10. change percent": "-0.2940%"
 }
 The IEXCLoud response is a much bigger JSON object.  Relevent fields:
 {
    symbol: <string>,
    open: <number>,
    high: <number>,
    low: <number>,
    close: <number>,
    change: <number>,
    changePercent: <number>
    ...
    <and more>
 }
 The FinancialModelingPrep response is also a big JSON object.
 This is real-time pricing.
 There is a smaller 'quote-short' endpoint for just real-time price.
 Relevent fields:
 {
    symbol: <string>,
    open: <number>,
    dayHigh: <number>,
    dayLow: <number>,
    price: <number>,
    change: <number>,
    changesPercentage: <number>
    ...
    <and more>
 }
 */
struct Quote: Codable {
    var symbol: String
    var open: Double = 0.0
    var high: Double = 0.0
    var low: Double = 0.0
    var price: Double = 0.0
    var change: Double = 0.0
    var changePercent: Double = 0.0
    
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
    }
    
    init( symbol: String ) {
        self.symbol = symbol
    }

    /*
    // Alphavantage
    // Note: values (numbers) are given as strings.
    private enum CodingKeys: String, CodingKey {
        case symbol = "01. symbol"
        case open = "02. open"
        case high = "03. high"
        case low = "04. low"
        case price = "05. price"
        case change = "09. change"
        case changePercent = "10. change percent"
    }
     // IEXCloud version:
     private enum CodingKeys: String, CodingKey {
         case symbol = "symbol"
         case open = "open"
         case high = "high"
         case low = "low"
         case price = "close"
         case change = "change"
         case changePercent = "changePercent"
     }
*/
}

extension Quote: Identifiable {
    var id: UUID {
        return UUID()
    }
}
