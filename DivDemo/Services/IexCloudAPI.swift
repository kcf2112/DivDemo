//
//  IexCloudAPI.swift
//  DivDemo
//
//  Created by Kevin Filer on 4/16/22.
//

import Foundation

struct IexCloudAPI {
    static var baseUrl = "https://cloud.iexapis.com/stable"
    static var key = "sk_66d4a67adc4746e0a0d948e0e6484e71"
    
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
            return "\(baseUrl)/stock/\(searchTerm)/\(searchMode.rawValue)?token=\(key)"
        case .search :
            return "\(baseUrl)/BOGUS"
        }
    }
}
