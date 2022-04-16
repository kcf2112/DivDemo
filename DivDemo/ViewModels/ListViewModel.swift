//
//  ListViewModel.swift
//  DivDemo
//
//  Created by Kevin Filer on 4/13/22.
//

import Foundation

class ListViewModel : ObservableObject {
    
    @Published var securities: [Security] = [] {
        didSet {
            saveSecurities()
        }
    }
    
    let securitiesKey = "securities_list"
    
    init() {
        getSecurities()
    }
    
    func addSecurity( symbol: String, shares: Double ) {
        securities.append( Security( symbol: symbol, shares: shares ) )
    }
    
    func deleteSecurity( indexSet: IndexSet ) {
        securities.remove( atOffsets: indexSet )
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
