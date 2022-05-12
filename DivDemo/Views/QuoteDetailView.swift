//
//  QuoteDetailView.swift
//  DivDemo
//
//  Created by Kevin Filer on 4/8/22.
//

import SwiftUI

struct QuoteDetailView: View {
    
    @State private var quotes = [Quote]()
    var security: Security
    let format = "%.2F"
    
    var body: some View {
        Text( "\(security.symbol) Quote Detail" )
            .font( .headline )
        List( quotes ) { quote in
            VStack( alignment: .leading ) {
                Text( "High: \(quote.high, specifier: format)" )
                Text( "Low: \(quote.low, specifier: format)" )
                Text( "Close: \(quote.price, specifier: format)" ).bold()
                Text( "Change: \(quote.change, specifier: format)" )
                Text( "% Chg: \(quote.changePercent)" )
                    .foregroundColor( quote.changePercent < 1 ? .red : .green )
            }
        }
        .task {
            await loadQuote()
        }
    }
    
    init( security: Security ) {
        self.security = security
    }
    
    func loadQuote() async {
        quotes.removeAll()
        let targetUrl = FinancialModelingPrepAPI.quoteUrl( for: security.symbol )
        
        guard let url = URL( string: targetUrl ) else {
            fatalError( "Could not create URL from \(targetUrl)" );
        }
            
        do {
            let (data, _) = try await URLSession.shared.data( from: url )
            if let decoded = try? JSONDecoder().decode( [Quote].self, from: data ) {
                if decoded.isEmpty {
                    print( "decodedResponse: No Data" )
                    quotes.append( Quote( symbol: self.security.symbol) )
                }
                else {
                    print( "decodedResponse: \(decoded[0])" )
                    quotes.append( decoded[0] )
                }
            }
        }
        catch {
            fatalError( "Could not retrieve data" );
        }
    }
    
    func loadQuote_SAVE() async {
        let targetUrl = FinancialModelingPrepAPI.quoteUrl( for: security.symbol )
        print( "targetUrl: \(targetUrl)" )
        
        guard let url = URL( string: targetUrl ) else {
            fatalError( "Could not create URL from \(targetUrl)" );
        }
            
        do {
            let (data, _) = try await URLSession.shared.data( from: url )
            if let decoded = try? JSONDecoder().decode( [Quote].self, from: data ) {
                if decoded.isEmpty {
                    print( "decodedResponse: No Data" )
                    quotes.append( Quote( symbol: self.security.symbol) )
                }
                else {
                    print( "decodedResponse: \(decoded[0])" )
                    quotes.append( decoded[0] )
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
        
        guard let quote = try? JSONDecoder().decode( Quote.self, from: data ) else {
            fatalError( "Could not decode \(file) from bundle." );
        }
        quotes.append( quote )
    }
}

struct QuoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteDetailView( security: Security( symbol: "ABC", shares: 1000 ) )
    }
}
