//
//  DividendTTMView.swift
//  DivDemo
//
//  Created by Kevin Filer on 5/11/22.
//

import SwiftUI

struct DividendTTMView: View {
    //@State private var divData = [DivInfo]()
    @StateObject var divViewModel = DividendViewModel()
    
    var security: Security
    let longFmt = "%.6f"
    let shortFmt = "%.2f"

    var body: some View {
        Text( "\(security.symbol) Dividend Trailing 12 Months (TTM)" )
            .font( .title3.bold() )
        List {
            VStack( alignment: .leading ) {
                Text( "Yield TTM: \(divViewModel.divInfo.dividendYieldTTM, specifier: longFmt)" )
                Text( "Yield % TTM: \(divViewModel.divInfo.dividendYieldPercentageTTM, specifier: longFmt)" )
                Text( "$ PerShare TTM: \(divViewModel.divInfo.dividendPerShareTTM, specifier: longFmt)" )
                Text( "Dividend Total TTM: \(divViewModel.getDividendPaidTTM(dollarAmount: security.dollarAmount ), specifier: shortFmt)" ).font( .headline )
            }
        }
        .task {
            await divViewModel.loadDividend( security: security )
        }
    }
    
    init( security: Security ) {
        self.security = security
    }
}

struct DividendTTMView_Previews: PreviewProvider {
    static var previews: some View {
        DividendTTMView( security: Security( symbol: "AAPL", dollarAmount: 10000 ) )
    }
}
