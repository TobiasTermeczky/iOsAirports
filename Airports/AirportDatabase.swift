//
//  AirportDatabase.swift
//  Airports
//
//  Created by Tobias Termeczky@hotmail.com on 17/10/2017.
//  Copyright © 2017 Tobias Termeczky@hotmail.com. All rights reserved.
//

import Foundation
import SQLite3

class AirportDatabase: NSObject {
    static let sharedInstance = AirportDatabase()
    
    var db : OpaquePointer? = nil
    
    override init() {
        
        let path = Bundle.main.path(forResource: "airports", ofType: "sqlite");
        
        if sqlite3_open(path!, &db) != SQLITE_OK {
            print("error opening airports database")
        }
    }
    
    func getSections() -> [Section]? {
        var sections = [Section]()
        let countries = getCountryGrouped()
        for name in countries! {
            let section = Section(country: name, airports: getAirportsByIso(name)!, expanded: false)
            sections.append(section)
        }
        
        return sections
    }
    
    func getCountryGrouped() -> [String]? {
        var countries = [String]()
        
        let query = "SELECT iso_country FROM airports GROUP BY iso_country"
        
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error query: \(errmsg)")
            return .none
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            var country = String()
            country = String(cString: sqlite3_column_text(statement, 0))
            countries.append(country)
        }
        return countries
    }
    
    func getAirportsByIso(_ iso_country : String ) -> [Airport]? {
        
        var airports = [Airport]()
        
        let query = "SELECT * FROM airports WHERE iso_country = \"\(iso_country)\" LIMIT 10"
        
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error query: \(errmsg)")
            return .none
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            let airport = Airport()
            
            airport.icao = String(cString: sqlite3_column_text(statement, 0))
            airport.name = String(cString: sqlite3_column_text(statement, 1))
            
            airport.longitude = sqlite3_value_double(sqlite3_column_value(statement, 2))
            airport.latitude = sqlite3_value_double(sqlite3_column_value(statement, 3))
            airport.elevation = sqlite3_value_double(sqlite3_column_value(statement, 4))
            
            airport.iso_country = String(cString: sqlite3_column_text(statement, 5))
            airport.municipality = String(cString: sqlite3_column_text(statement, 6))
            
            airports.append(airport)
        }
        
        return airports
    }
}
