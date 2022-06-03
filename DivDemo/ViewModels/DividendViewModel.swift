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
            // TODO: Post error for user
            fatalError( "Could not retrieve DividendTTM data: \(error.localizedDescription)" );
        }
    }
}
