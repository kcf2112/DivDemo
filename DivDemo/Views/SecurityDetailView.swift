//
//  SecurityDetailView.swift
//  DivDemo
//
//  Created by Kevin Filer on 5/11/22.
//

import SwiftUI

struct SecurityDetailView: View {
    var security: Security
    @State private var showingProfile = false
    
    var body: some View {
        NavigationView {
            VStack( /*alignment: .leading*/ ) {
                
                QuoteDetailView( security: security )
                //Spacer()
                DividendTTMView( security: security )
                //Spacer()
                
                Button( action: {
                    showingProfile = !showingProfile
                }, label: {
                    Text( "Profile" )
                    .frame( width: 200, height: 40 )
                    .foregroundColor( .white )
                    .background( Color.blue )
                    .cornerRadius( 12 )
                    .padding()
                } )
            }
            .padding()
            .sheet( isPresented: $showingProfile ) {
                ProfileView( security: security )
            }
        }
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
