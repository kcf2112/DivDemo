//
//  ProfileViewModel.swift
//  DivDemo
//
//  Created by Kevin Filer on 6/10/22.
//

import Foundation
import SwiftUI

class ProfileViewModel : ObservableObject {
    
    @Published var profile = Profile()
    @Published var logoImage: UIImage? = nil
    
    @MainActor
    func loadProfile( security: Security ) async {
        print( "ProfileViewModel loadProfile: Entry" )

        // TODO:
        // Research: @MainActor vs await MainActor.run( body: { <async code here> } )
        
        let targetUrl = FinancialModelingPrepAPI.profileUrl( for: security.symbol )
        print( "ProfileViewModel loadProfile: targetUrl: \(targetUrl)" )
        
        let httpService = HttpService<Profile>( urlString: targetUrl )
        do {
            profile = try await httpService.getJSON()
            await retrieveImage( urlString: profile.image )
        }
        catch {
            if( error.localizedDescription.contains( "cancelled" ) ) {
                // Not a true retrieval error, a routine task cancellation
                print( "ProfileViewModel: Data task cancelled: \(error)" );
            }
            else {
                print( "ProfileViewModel: Could not retrieve profile data: \(error)" );
            }
            profile = Profile()
        }
    }
    
    @MainActor
    func retrieveImage( urlString: String ) async {
        print( "ProfileViewModel retrieveImage: Entry with image urlString \(urlString)" )

        let imageService = ImageDownloadService()
        if let image: UIImage = try? await imageService.download( urlString: urlString ) {
            self.logoImage = image
        }
    }
}
