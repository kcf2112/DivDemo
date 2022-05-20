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
        }
    }
    
    init( security: Security ) {
        self.security = security
    }    
}

struct QuoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteDetailView( security: Security( symbol: "ABC", dollarAmount: 10000 ) )
    }
}
