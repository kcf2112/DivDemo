//
//  DividendTTMView.swift
//  DivDemo
//
//  Created by Kevin Filer on 5/11/22.
//

import SwiftUI

struct DividendTTMView: View {
    @State private var divData = [DivInfo]()
    var security: Security
    let longFmt = "%.6f"
    let shortFmt = "%.2f"

    var body: some View {
        Text( "\(security.symbol) Dividend Trailing 12 Months (TTM)" )
            .font( .headline )
        List( divData ) { div in
            VStack( alignment: .leading ) {
                Text( "Dividend Yield TTM: \(div.dividendYieldTTM, specifier: longFmt)" )
                Text( "Dividend Yield % TTM: \(div.dividendYieldPercentageTTM, specifier: longFmt)" )
                Text( "Dividend PerShare TTM: \(div.dividendPerShareTTM, specifier: longFmt)" )
                Text( "Dividend Total TTM: \(div.getDividendPaidTTM( shares: security.shares ), specifier: shortFmt)" )
            }
        }
        .task {
            await loadDividend()
        }
    }
    
    init( security: Security ) {
        self.security = security
    }
    
    func loadDividend() async {
        divData.removeAll()
        let targetUrl = FinancialModelingPrepAPI.dividendTtmUrl( for: security.symbol )
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
        DividendTTMView( security: Security( symbol: "AAPL", shares: 1000 ) )
    }
}
