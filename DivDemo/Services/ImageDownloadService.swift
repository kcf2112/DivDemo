//
//  ImageDownloadService.swift
//  DivDemo
//
//  Created by Kevin Filer on 6/18/22.
//

import Foundation
import SwiftUI

struct ImageDownloadService {

    //let testUrl = URL( string: "https://picsum.photos/200" )!
    
    @MainActor
    func download( urlString: String ) async throws -> UIImage? {
        //  Verify the URL
        guard
            let url = URL( string: urlString )
        else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data( from: url )
        guard
            let image = UIImage( data: data ),
            let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
        else {
            return nil // Default system image?
        }
        return image
    }
 }
