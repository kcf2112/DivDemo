//
//  ProfileViewModel.swift
//  DivDemo
//
//  Created by Kevin Filer on 6/10/22.
//

import Foundation

@MainActor
class ProfileViewModel : ObservableObject {
    
    @Published var profile = Profile()
    
    func loadProfile( security: Security ) async {
        
        // TODO:
        // @MainActor vs await MainActor.run( body: { <async code here> } )
        //
        
        let targetUrl = FinancialModelingPrepAPI.profileUrl( for: security.symbol )
        print( "ProfileViewModel targetUrl: \(targetUrl)" )
        
        let httpService = HttpService<Profile>( urlString: targetUrl )
        do {
            profile = try await httpService.getJSON()
        }
        catch {
            if( error.localizedDescription == "cancelled" ) {
                // Not a true retrieval error, a routine task cancellation
            }
            else {
                print( "Could not retrieve Profile: \(error)" );
            }
            profile = Profile()
        }
    }
}
