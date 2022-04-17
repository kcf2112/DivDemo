//
//  DividendQueryView.swift
//  DivDemo
//
//  Created by Kevin Filer on 4/17/22.
//

import SwiftUI

struct DividendQueryView: View {
    @State private var fromDate = // Default: 90 days ago.
        Calendar.current.date(
            byAdding: DateComponents( day: -90 ), to: Date() ) ?? Date.now
    @State private var toDate = Date.now
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker( "From date", selection: $fromDate, displayedComponents: .date )
                    .padding()
                    //.datePickerStyle( WheelDatePickerStyle() )
                DatePicker( "To date", selection: $toDate, displayedComponents: .date )
                    .padding()
            }
            .navigationTitle( "Dividend Query" )
        }
    }
}

struct DividendQueryView_Previews: PreviewProvider {
    static var previews: some View {
        DividendQueryView()
    }
}
