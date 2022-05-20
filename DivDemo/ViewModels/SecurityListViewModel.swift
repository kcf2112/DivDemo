//
//  StockListViewModel.swift
//  DivDemo
//
//  Created by Kevin Filer on 4/17/22.
//

import Foundation

/*
 Provides data handling for a list of securities maintained
 by the user -- stocks, mutual funds, ETFs.
 */
class SecurityListViewModel : ObservableObject {
    
    @Published var securities: [Security] = [] {
        // Save the updated list when user makes a change.
        didSet {
            saveSecurities()
        }
    }
    
    let securitiesKey = "securities_list"
    
    init() {
        getSecurities()
    }
    
    func add( symbol: String, dollarAmount: Int ) {
        securities.append( Security( symbol: symbol, dollarAmount: dollarAmount ) )
    }
    /*
    func addByShares( symbol: String, shares: Double ) {
        securities.append( Security( symbol: symbol, shares: shares ) )
    }*/

    func delete( indexSet: IndexSet ) {
        securities.remove( atOffsets: indexSet )
    }
    
    func hasSymbol( _ symbol: String ) -> Bool {
        for item in securities {
            if symbol == item.symbol {
                return true
            }
        }
        return false
    }
    
    func getSecurities() {
        guard
            let jsonData = UserDefaults.standard.data( forKey: securitiesKey ),
            let savedSecurities = try? JSONDecoder().decode( [Security].self, from: jsonData )
        else {
            return
        }
        securities = savedSecurities
    }
    
    func moveSecurity( from: IndexSet, to: Int ) {
        securities.move( fromOffsets: from, toOffset: to )
    }
    
    func saveSecurities() {
        // See securities.didSet above
        if let jsonData = try? JSONEncoder().encode( securities ) {
            UserDefaults.standard.set( jsonData, forKey: securitiesKey )
        }
    }
}
