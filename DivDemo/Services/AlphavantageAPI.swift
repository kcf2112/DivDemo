//
//  AlphavantageAPI.swift
//  DivDemo
//
//  Created by Kevin Filer on 4/7/22.
//
// *** NOT CURRENTLY USED ***

import Foundation

struct AlphavantageAPI {
    static var baseUrl = "https://www.alphavantage.co/query?"
    static var key = "6VR4KNAJE14WGPPJ"
    
    enum SearchFunction: String {
        case quote = "GLOBAL_QUOTE"
        case search = "SYMBOL_SEARCH"
    }
    
    /*
     Query URL for price quote info on a specific known equity.
     */
    static func quoteUrl( for equitySymbol: String ) -> String {
        return urlBy( searchMode: .quote, searchTerm: equitySymbol )
    }
    
    /*
     Query URL to search for equity symbols that match the search term.
     */
    static func symbolSearchUrl( for searchTerm: String ) -> String {
        return urlBy( searchMode: .search, searchTerm: searchTerm )
    }
    
    /*
     Uses search mode (SearchFunction) to build the right query URL.
     */
    private static func urlBy( searchMode: SearchFunction, searchTerm: String ) -> String {
        switch searchMode {
        case .quote :
            return "\(baseUrl)function=\(searchMode.rawValue)&apikey=\(key)&symbol=\(searchTerm)"
        case .search :
            return "\(baseUrl)function=\(searchMode.rawValue)&apikey=\(key)&keywords=\(searchTerm)"
        }
    }
}
