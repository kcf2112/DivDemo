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
        
        let httpService = HttpService<Quote>( urlString: targetUrl )
        do {
            quote = try await httpService.getJSON()
        }
        catch {
            // TODO: Post error for user
            fatalError( "Could not retrieve DividendTTM data: \(error.localizedDescription)" );
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
