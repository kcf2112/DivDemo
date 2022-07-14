//
//  DivInfo.swift
//  DivDemo
//
//  Created by Kevin Filer on 3/29/22.
//

import Foundation

struct DividendTTM : Codable {
    
    var dividendYieldTTM: Double = 0.0
    var dividendYieldPercentageTTM: Double = 0.0
    var dividendPerShareTTM: Double = 0.0
    
    var historicalPrice: Double = 0.0
    var historicalPriceDate: Date?
    var shares: Double = 0.0
    
    var formattedShares: String {
        return String( format: "%.2f", shares )
    }
    
    // If this enum is present, ONLY these fields will
    // be decoded.  The enum must contain all needed fields.
    // FMP version:
    private enum CodingKeys: String, CodingKey {
        case dividendYieldTTM = "dividendYieldTTM"
        case dividendYieldPercentageTTM = "dividendYieldPercentageTTM"
        case dividendPerShareTTM = "dividendPerShareTTM"
    }    
}

extension DividendTTM: Identifiable {
    var id: UUID {
        return UUID()
    }
}
