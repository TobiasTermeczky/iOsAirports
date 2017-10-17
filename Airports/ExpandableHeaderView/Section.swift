//
//  Section.swift
//  Airports
//
//  Created by Tobias Termeczky@hotmail.com on 17/10/2017.
//  Copyright © 2017 Tobias Termeczky@hotmail.com. All rights reserved.
//

import Foundation

struct Section {
    var country: String!
    var airports: [Airport]!
    var expanded: Bool!
    
    init(country: String, airports: [Airport], expanded: Bool){
        self.country = country
        self.airports = airports
        self.expanded = expanded
    }
}
