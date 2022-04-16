//
//  AvCodingKeys.swift
//  DivDemo
//
//  Created by Kevin Filer on 4/16/22.
//

import Foundation

enum CodingKeys: String, CodingKey {
    case symbol = "01. symbol"
    case open = "02. open"
    case high = "03. high"
    case low = "04. low"
    case price = "05. price"
    case change = "09. change"
    case changePercent = "10. change percent"
}
