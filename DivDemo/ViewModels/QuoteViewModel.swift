//
//  QuoteViewModel.swift
//  DivDemo
//
//  Created by Kevin Filer on 5/18/22.
//

import Foundation

@MainActor
class QuoteViewModel : ObservableObject {
    
    @Published var quote = Quote( symbol: "" )
    
    func loadQuote( security: Security ) async {
        let targetUrl = FinancialModelingPrepAPI.quoteUrl( for: security.symbol )
        print( "QuoteDetailView targetUrl: \(targetUrl)" )
        
        guard let url = URL( string: targetUrl ) else {
            fatalError( "Could not create URL from \(targetUrl)" );
        }
            
        do {
            let (data, _) = try await URLSession.shared.data( from: url )
            
            if let decoded = try? JSONDecoder().decode( [Quote].self, from: data ) {
                if decoded.isEmpty {
                    //print( "decodedResponse: No data returned for \(security.symbol" )
                    quote = Quote( symbol: security.symbol )
                }
                else {
                    //print( "decodedResponse: \(decoded[0])" )
                    quote = decoded[0]
                }
            }
        }
        catch {
            fatalError( "Could not retrieve data" );
        }
    }
    
    func loadQuoteFromFile() async {
        let file = "basic_quote.json"
        
        guard let url =
                Bundle.main.url( forResource: file, withExtension: nil ) else {
            fatalError( "Could not find \(file) in bundle." );
        }
        
        guard let data = try? Data( contentsOf: url ) else {
            fatalError( "Could not load \(file) from bundle." );
        }
        
        guard let fquote = try? JSONDecoder().decode( Quote.self, from: data ) else {
            fatalError( "Could not decode \(file) from bundle." );
        }
        quote = fquote
    }
}
