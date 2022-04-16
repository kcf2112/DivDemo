//
//  FinancialModelingPrepAPI.swift
//  DivDemo
//
//  Created by Kevin Filer on 4/16/22.
//

import Foundation

struct FinancialModelingPrepAPI {
    static var baseUrl = "https://financialmodelingprep.com/api/v3"
    static var key = "53e76c4ab5b5e09fab50a4ba8d2d1d4b"
    
    enum SearchFunction: String {
        case quote = "quote"
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
            return "\(baseUrl)/\(searchMode.rawValue)/\(searchTerm)?apikey=\(key)"
        case .search :
            return "\(baseUrl)/BOGUS"
        }
    }
}
