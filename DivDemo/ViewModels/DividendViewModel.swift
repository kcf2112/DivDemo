//
//  DividendViewModel.swift
//  DivDemo
//
//  Created by Kevin Filer on 4/17/22.
//

import Foundation

@MainActor
class DividendViewModel : ObservableObject {
    
    @Published var divInfo = DivInfo()
    
    func loadDividend( security: Security ) async {
        let targetUrl = FinancialModelingPrepAPI.dividendTtmUrl( for: security.symbol )
        print( "DividendTTMView targetUrl: \(targetUrl)" )
        
        guard let url = URL( string: targetUrl ) else {
            fatalError( "Could not create URL from \(targetUrl)" );
        }
            
        do {
            let (data, _) = try await URLSession.shared.data( from: url )
            if let decoded = try? JSONDecoder().decode( [DivInfo].self, from: data ) {
                //print( "DividendViewModel decodedResponse: \(decoded[0])" )
                if decoded.isEmpty {
                    //print( "DividendViewModel decodedResponse: No Data" )
                    divInfo = DivInfo()
                }
                else {
                    //print( "DividendViewModel decodedResponse: \(decoded[0])" )
                    divInfo = decoded[0]
                }
            }
            else {
                fatalError( "Could not decode DividendTTM data" );
            }
        }
        catch {
            fatalError( "Could not retrieve DividendTTM data" );
        }
    }
}
