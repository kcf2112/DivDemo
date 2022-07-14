//
//  HistoricalData.swift
//  DivDemo
//
//  Created by Kevin Filer on 7/11/22.
//

import Foundation

struct Historical : Codable {
    var close: Double = 0.0
    //var dateString: String = ""
    var date: Date = Date()

    // If this enum is present, ONLY these fields will
    // be decoded.  The enum must contain all needed fields.
    // FMP version:
    private enum CodingKeys: String, CodingKey {
        case close = "close"
        case date = "date"
    }
}

struct HistoricalFMPData : Codable {
    var symbol: String = ""
    var historical: [Historical] = []
}

//struct HistoricalData {
//    var symbol: String = ""
//    var dateString: String = ""
//    var close: Double = 0.0
//}

