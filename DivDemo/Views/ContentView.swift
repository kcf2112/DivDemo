//
//  ContentView.swift
//  DivDemo
//
//  Created by Kevin Filer on 3/13/22.
//

import SwiftUI

struct ContentView: View {
    
    var divData: [DivInfo] = [
        DivInfo( symbol: "DIVO",
                 payDate: "Mar 2022", dividend: 0.1507, shares: 1000 ),
        DivInfo( symbol: "DVY",
                 payDate: "Mar 2022", dividend: 0.1809, shares: 1200 ),
        DivInfo( symbol: "FGRIX",
                 payDate: "Mar 2022", dividend: 0.12012, shares: 439.6 ),
        DivInfo( symbol: "LBSAX",
                 payDate: "Mar 2022", dividend: 0.11012, shares: 511.39 ),
        DivInfo( symbol: "PARWX",
                 payDate: "Mar 2022", dividend: 0.1401, shares: 621.71 )
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach( divData ) { div in
                    NavigationLink {
                        //Text( "Details: \(div.symbol)" )
                        QuoteDetailView( symbol: div.symbol );
                    } label: {
                        VStack( alignment: .leading ) {
                            Text( "\(div.symbol)" )
                            Text( "Pay date: \(div.payDate)" )
                            Text( "Dividend: \(div.dividend)" )
                            Text( "Shares: \(div.shares)" )
                            Text( "Paid: \(div.paid, format: .currency( code: "usd" ))" )
                        }
                        .padding()
                        .frame( width: 220 )
                    }
                }
            }
            .navigationTitle( "Div Demo" )
            .navigationBarItems(
                trailing: NavigationLink( "Add", destination: AddView() ) )
        }
        
        /*
        List {
            ForEach( divData ) { div in
                VStack( alignment: .leading ) {
                    Text( "\(div.symbol)" )
                    Text( "Pay date: \(div.payDate)" )
                    Text( "Dividend: \(div.dividend)" )
                    Text( "Shares: \(div.shares)" )
                    Text( "Paid: \(div.paid, format: .currency( code: "usd" ))" )
                }
                .padding()
                .frame( width: 220 )
                
            }
        }
        
        / *
        NavigationView {
            ScrollView {
                VStack( alignment: .leading ) {
                    Text( "DIVO" )
                    Text( "DVY" )
                    Text( "FBGRIX" )
                    Text( "LBSAX" )
                }
            }
            .navigationTitle( "Div Demo" )
        }*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
