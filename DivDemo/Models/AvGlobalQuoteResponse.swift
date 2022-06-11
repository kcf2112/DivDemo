//
//  AvGlobalQuote.swift
//  DivDemo
//
//  Created by Kevin Filer on 4/9/22.
//
// See alphavantage_quote.json for an example.

import Foundation

struct AvGlobalQuoteResponse : Codable {
    var quote: Quote
    
    private enum CodingKeys: String, CodingKey {
        case quote = "Global Quote"
    }
    
    /*
    // Alphavantage quote info
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
