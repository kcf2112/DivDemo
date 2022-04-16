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
}
