//
//  AddView.swift
//  DivDemo
//
//  Created by Kevin Filer on 4/13/22.
//

import SwiftUI

struct AddView: View {
    @Environment( \.presentationMode ) var presentationMode
    //@EnvironmentObject var securityListViewModel: SecurityListViewModel
    @ObservedObject var securityListViewModel: SecurityListViewModel

    @State var symbol: String = ""
    @State var shares: String = ""

    @State var alertTitle = ""
    @State var showAlert = false
    var numShares = 0.0
    
    var body: some View {
        ScrollView {
            VStack {
                TextField( "Ticker symbol", text: $symbol )
                    .padding( .horizontal )
                    .frame( height: 55 )
                    .background( Color( red: 0.789, green: 0.831, blue: 0.841)  )
                    .cornerRadius( 10 )
                TextField( "Number of shares", text: $shares )
                    .padding( .horizontal )
                    .frame( height: 55 )
                    .background( Color( red: 0.789, green: 0.831, blue: 0.841)  )
                    .cornerRadius( 10 )
                Button(
                    action: onSave,
                    label: {
                        Text( "Save".uppercased() )
                            .foregroundColor( .white )
                            .frame( height: 55 )
                            .frame( maxWidth: .infinity )
                            .background( Color.accentColor )
                            .cornerRadius( 10 )
                    } )
            }
            .padding( 14 )
        }
        .navigationTitle( "Add a security 🖊" )
        .alert( isPresented: $showAlert, content: getAlert )
    }
    
    func onSave() {
        if !isValid() {
            return
        }
        let numShares = Double( shares ) ?? 0.0
        securityListViewModel.addSecurity( symbol: symbol, shares: numShares )
        presentationMode.wrappedValue.dismiss() // Go back in hierarchy.
    }
    
    func isValid() -> Bool {
        // TODO: Add validation logic or remove this.
        return true
    }
    
    func getAlert() -> Alert {
        return Alert( title: Text( alertTitle ) )
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView( securityListViewModel: SecurityListViewModel() )
    }
}
