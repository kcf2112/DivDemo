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

    static var dateFormat: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        return fmt
    }()
    
    enum SearchFunction: String {
        case dividend = "key-metrics-ttm"
        case profile = "profile"
        case quote = "quote"
        case search = "--SYMBOL_SEARCH--"
    }
    
    /*
     Query URL for trailing 12 months (TTM) dividend payment.
     */
    static func dividendTtmUrl( for equitySymbol: String ) -> String {
        return urlBy( searchMode: .dividend, searchTerm: equitySymbol, dates: [] )
    }
    
    static func dividendUrl_TEST( for equitySymbol: String, fromDate: Date, toDate: Date ) -> String {
        var dateStr: [String] = []
        dateStr.append( dateFormat.string( from: fromDate ) )
        dateStr.append( dateFormat.string( from: toDate ) )
        return urlBy( searchMode: .dividend, searchTerm: equitySymbol, dates: dateStr )
    }

    /*
     Query URL for company profile information.
     */
    static func profileUrl( for equitySymbol: String ) -> String {
        return urlBy( searchMode: .profile, searchTerm: equitySymbol, dates: [] )
    }
    
    /*
     Query URL for price quote info on a specific known equity/security.
     */
    static func quoteUrl( for equitySymbol: String ) -> String {
        return urlBy( searchMode: .quote, searchTerm: equitySymbol, dates: [] )
    }
    
    /*
     Query URL to search for equity symbols that match the search term.
     */
    static func symbolSearchUrl( for searchTerm: String ) -> String {
        return urlBy( searchMode: .search, searchTerm: searchTerm, dates: [] )
    }
    
    /*
     Uses search mode (SearchFunction enum) to build the query URL.
     */
    private static func urlBy( searchMode: SearchFunction, searchTerm: String, dates: [String] ) -> String {
        switch searchMode {
        case .dividend :
            return "\(baseUrl)/\(searchMode.rawValue)/\(searchTerm)?limit=40&apikey=\(key)"
        case .profile,
             .quote :
            return "\(baseUrl)/\(searchMode.rawValue)/\(searchTerm)?apikey=\(key)"
        case .search :
            return "\(baseUrl)/BOGUS"
        }
    }
}
