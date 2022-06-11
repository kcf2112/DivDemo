//
//  Profile.swift
//  DivDemo
//
//  Created by Kevin Filer on 6/9/22.
//

import Foundation

/*
 Represent company/fund profile information.
 */
struct Profile : Codable {
    
    var symbol: String = ""
    var companyName: String = ""
    var description: String = ""
    var image: String = "" // Image URL.
    
    // If this enum is present, ONLY these fields will
    // be decoded.  The enum must contain all needed fields.
    // FMP version:
    /*
    private enum CodingKeys: String, CodingKey {
        case dividendYieldTTM = "dividendYieldTTM"
        case dividendYieldPercentageTTM = "dividendYieldPercentageTTM"
        case dividendPerShareTTM = "dividendPerShareTTM"
    }
    */
}

extension Profile: Identifiable {
    var id: UUID {
        return UUID()
    }
}
