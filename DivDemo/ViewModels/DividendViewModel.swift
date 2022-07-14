//
//  DividendViewModel.swift
//  DivDemo
//
//  Created by Kevin Filer on 4/17/22.
//

import Foundation

class DividendViewModel : ObservableObject {
    
    @Published var divInfo = DividendTTM()
    
    @MainActor
    func loadDividend( security: Security ) async {
        
        // TODO:
        // @MainActor vs await MainActor.run( body: { <async code here> } )
        
        let dividendUrl =
            FinancialModelingPrepAPI.dividendTtmUrl( for: security.symbol )
        print( "DividendViewModel dividendUrl: \(dividendUrl)" )
        
        let dividendHttpSvc = HttpService<DividendTTM>( urlString: dividendUrl )
        
        do {
            //divInfo = try await dividendHttpSvc.getJSON()
            var tempDiv = try await dividendHttpSvc.getJSON()
            
            // Add the historical data
            let histData: HistoricalFMPData = await retrieveHistoricalPrice( security: security )
            print( "DividendViewModel: HistoricalFMPData: \(histData)" );
            
            tempDiv.historicalPrice = histData.historical[0].close
            divInfo = tempDiv
        }
        catch {
            if( error.localizedDescription == "cancelled" ) {
                // Not a true retrieval error, a routine task cancellation
            }
            else {
                print( "Could not retrieve DividendTTM: \(error)" );
            }
            divInfo = DividendTTM()
        }
    }
    
    func getDividendPaidTTM( dollarAmount: Int ) -> Double {
        return (Double( dollarAmount ) / divInfo.historicalPrice) * divInfo.dividendPerShareTTM
    }
    
    func retrieveHistoricalPrice( security: Security ) async -> HistoricalFMPData {
        let now = Date()
        let fromDate = Calendar.current.date( byAdding: .year, value: -1, to: now )!
        let toDate = Calendar.current.date( byAdding: .day, value: 5, to: fromDate )!

        let historicalUrl =
            FinancialModelingPrepAPI.historicalPriceUrl( for: security.symbol,
                                                         fromDate: fromDate, toDate: toDate )
        
        let historicalHttpSvc = HttpService<HistoricalFMPData>( urlString: historicalUrl )
        var historicalPrice: HistoricalFMPData
        do {
            historicalPrice =
                try await historicalHttpSvc.getJSON(
                            isJSONArray: false,
                            dateDecodingStrategy: .formatted( FinancialModelingPrepAPI.dateFormat ) )
            
            // Find the oldest price.
            var oldestPrice = Historical()
            for item in historicalPrice.historical {
                if item.date < oldestPrice.date {
                    oldestPrice = item
                }
            }
            historicalPrice.historical = [oldestPrice]
        }
        catch {
            if( error.localizedDescription == "cancelled" ) {
                // Not a true retrieval error, a routine task cancellation
            }
            else {
                print( "Could not retrieve HistoricalFMPData: \(error)" );
            }
            historicalPrice = HistoricalFMPData()
        }
        return historicalPrice
    }
}
