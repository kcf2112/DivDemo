//
//  QuoteDetailView.swift
//  DivDemo
//
//  Created by Kevin Filer on 4/8/22.
//

import SwiftUI

struct QuoteDetailView: View {
    
    @StateObject var quoteViewModel = QuoteViewModel()
    var security: Security
    let format = "%.2F"
    
    var body: some View {
        Text( "\(security.symbol) Quote Detail" )
            .font( .headline )
        //List( quotes ) { quote in
        List {
            VStack( alignment: .leading ) {
                Text( "High: \(quoteViewModel.quote.high, specifier: format)" )
                Text( "Low: \(quoteViewModel.quote.low, specifier: format)" )
                Text( "Close: \(quoteViewModel.quote.price, specifier: format)" ).bold()
                Text( "Change: \(quoteViewModel.quote.change, specifier: format)" )
                Text( "% Chg: \(quoteViewModel.quote.changePercent)" )
                    .foregroundColor( quoteViewModel.quote.changePercent < 1 ? .red : .green )
            }
        }
        .task {
            await quoteViewModel.loadQuote( security: security )
            //await loadQuoteTest()
        }
    }
    
    init( security: Security ) {
        self.security = security
    }
    /*
    func loadQuoteTest() async {
        print( "loadQuoteTest: Entry" )
        let targetUrl = FinancialModelingPrepAPI.quoteUrl( for: security.symbol )
        print( "Quote targetUrl: \(targetUrl)" )
        
        do {
            print( "loadQuoteTest: Build URL" )
            let url = URL( string: targetUrl )!
            print( "loadQuoteTest: Retrieve" )
            let (data, _) = try await URLSession.shared.data( from: url )
            print( "loadQuoteTest: Decode" )
            let decodedData = try JSONDecoder().decode( [Quote].self, from: data )
            var quote = decodedData[0]
        }
        catch {
            // TODO: Post error for user
            if let error = error as NSError?,
               error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
                // Not a true error condition, view was refreshed so previous task was cancelled.
                print( "Quote retrieval: Simple cancellation" )
            }
            else {
                print( "Quote retrieval: Network error: \(error)" )
            }
            return;
        }
    }*/

}

struct QuoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteDetailView( security: Security( symbol: "ABC", dollarAmount: 10000 ) )
    }
}
