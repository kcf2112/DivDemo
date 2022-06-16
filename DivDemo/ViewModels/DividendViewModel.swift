//
//  DividendViewModel.swift
//  DivDemo
//
//  Created by Kevin Filer on 4/17/22.
//

import Foundation

@MainActor
class DividendViewModel : ObservableObject {
    
    @Published var divInfo = DividendTTM()
    
    func loadDividend( security: Security ) async {
        
        // TODO:
        // @MainActor vs await MainActor.run( body: { <async code here> } )
        //
        
        let targetUrl = FinancialModelingPrepAPI.dividendTtmUrl( for: security.symbol )
        print( "DividendTTMView targetUrl: \(targetUrl)" )
        
        let httpService = HttpService<DividendTTM>( urlString: targetUrl )
        do {
            divInfo = try await httpService.getJSON()
        }
        catch {
            if( error.localizedDescription == "cancelled" ) {
                // Not a true retrieval error, a routine task cancellation
            }
            else {
                print( "Could not retrieve DividendTTM: \(error)" );
            }
            divInfo = DividendTTM()
        }
    }
}
