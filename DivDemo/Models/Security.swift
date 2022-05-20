//
//  Security.swift
//  DivDemo
//
//  Created by Kevin Filer on 4/13/22.
//

import Foundation

/*
 Represents an investment security such as a stock, mutual fund, or ETF.
 */
struct Security : Identifiable, Codable {
    var id = UUID()
    var symbol: String
    var dollarAmount: Int
    //var shares: Double
}
