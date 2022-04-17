//
//  ContentView.swift
//  DivDemo
//
//  Created by Kevin Filer on 3/13/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var securityListViewModel = SecurityListViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach( securityListViewModel.securities ) { sec in
                    NavigationLink {
                        QuoteDetailView( symbol: sec.symbol );
                    } label: {
                        VStack( alignment: .leading ) {
                            Text( "\(sec.symbol)" )
                            Text( "Shares: \(sec.shares)" )
                        }
                        .padding()
                        .frame( width: 220 )
                    }
                }
            }
            .navigationTitle( "Div Demo" )
            .navigationBarItems(
                trailing: NavigationLink(
                    "Add", destination: AddView( securityListViewModel: securityListViewModel ) ) )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
