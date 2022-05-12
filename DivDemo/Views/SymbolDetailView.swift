//
//  SymbolDetailView.swift
//  DivDemo
//
//  Created by Kevin Filer on 5/11/22.
//

import SwiftUI

struct SymbolDetailView: View {
    var symbol: String
    
    var body: some View {
        VStack( alignment: .leading ) {
            //QuoteDetailView( symbol: symbol )
            DividendTTMView( symbol: symbol )
        }
        .padding()
    }
    
    init( symbol: String ) {
        self.symbol = symbol
    }

}

struct SymbolDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolDetailView( symbol: "AAPL" )
    }
}
