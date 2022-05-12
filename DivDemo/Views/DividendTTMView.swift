//
//  DividendTTMView.swift
//  DivDemo
//
//  Created by Kevin Filer on 5/11/22.
//

import SwiftUI

struct DividendTTMView: View {
    @State private var divData = [DivInfo]()
    var symbol: String
    let format = "%.6f"
    
    var body: some View {
        Text( "\(symbol) Dividend Trailing 12 Months (TTM)" )
            .font( .headline )
        List( divData ) { div in
            VStack( alignment: .leading ) {
                Text( "Dividend Yield TTM: \(div.dividendYieldTTM, specifier: format)" )
                Text( "Dividend Yield % TTM: \(div.dividendYieldPercentageTTM, specifier: format)" )
                Text( "Dividend PerShare TTM: \(div.dividendPerShareTTM, specifier: format)" )
            }
        }
        .task {
            await loadDividend()
        }
    }
    
    init( symbol: String ) {
        self.symbol = symbol
    }
    
    func loadDividend() async {
        divData.removeAll()
        let targetUrl = FinancialModelingPrepAPI.dividendTtmUrl( for: symbol )
        print( "DividendTTMView targetUrl: \(targetUrl)" )
        
        guard let url = URL( string: targetUrl ) else {
            fatalError( "Could not create URL from \(targetUrl)" );
        }
            
        do {
            let (data, _) = try await URLSession.shared.data( from: url )
            print( "DividendTTMView data: \(data)" )
            
            if let decoded = try? JSONDecoder().decode( [DivInfo].self, from: data ) {
                print( "DividendTTMView decodedResponse: \(decoded[0])" )
                if decoded.isEmpty {
                    print( "DividendTTMView decodedResponse: No Data" )
                    divData.append( DivInfo() )
                }
                else {
                    print( "DividendTTMView decodedResponse: \(decoded[0])" )
                    divData.append( decoded[0] )
                }
            }
            else {
                fatalError( "Could not decode DividendTTM data" );
            }
        }
        catch {
            fatalError( "Could not retrieve DividendTTM data" );
        }
    }
}

struct DividendTTMView_Previews: PreviewProvider {
    static var previews: some View {
        DividendTTMView( symbol: "AAPL" )
    }
}
