//
//  SymbolDetailView.swift
//  DivDemo
//
//  Created by Kevin Filer on 5/11/22.
//

import SwiftUI

struct SecurityDetailView: View {
    var security: Security
    
    var body: some View {
        VStack( alignment: .leading ) {
            QuoteDetailView( security: security )
            DividendTTMView( security: security )
        }
        .padding()
    }
    
    init( security: Security ) {
        self.security = security
    }
}

struct SymbolDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityDetailView( security: Security( symbol: "DVY", dollarAmount: 10000 ) )
    }
}
