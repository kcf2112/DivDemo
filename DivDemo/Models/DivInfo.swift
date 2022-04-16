//
//  DivInfo.swift
//  DivDemo
//
//  Created by Kevin Filer on 3/29/22.
//

import Foundation

struct DivInfo : Identifiable, Codable {
    
    /*let sharesFormat = NumberFormatter()
    sharesFormat.numberStyle = .decimal
    sharesFormat.maximumFractionDigits = 2*/
    
    
    var id = UUID()
    var symbol: String
    //var payDate: Date
    var payDate: String
    var dividend: Double
    var shares: Double
    var paid: Double {
        get { shares * dividend }
    }
    
    var formattedShares: String {
        return String( format: "%.2f", shares )
    }
}
