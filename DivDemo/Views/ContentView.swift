//
//  ContentView.swift
//  DivDemo
//
//  Created by Kevin Filer on 3/13/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var securityListVM = SecurityListViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach( securityListVM.securities ) { sec in
                    NavigationLink {
                        SecurityDetailView( security: sec );
                    } label: {
                        VStack( alignment: .leading ) {
                            Text( "\(sec.symbol)" )
                            Text( "$ Amount: \(sec.dollarAmount)" )
                        }
                        .padding()
                        .frame( width: 220 )
                    }
                }
                .onDelete( perform: deleteItem )
            }
            .navigationTitle( "Div Demo" )
            .navigationBarItems(
                trailing: NavigationLink(
                    "Add", destination: AddView( securityListViewModel: securityListVM ) ) )
        }
    }
    
    func deleteItem( at indexSet: IndexSet ) {
        securityListVM.delete( indexSet: indexSet )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
