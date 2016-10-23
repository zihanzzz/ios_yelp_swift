//
//  Filter.swift
//  Yelp
//
//  Created by James Zhou on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class Filter: NSObject {
    
    var dealsBool: Bool!
    
    var radiusEnum: YelpDistance!
    
    var sortModeEnum: YelpSortMode!
    
    var categoryStates = [Int:Bool]()
    
    init(deals: Bool?, radius: YelpDistance?, sortMode: YelpSortMode?, categoriesStates: [Int:Bool]) {
        super.init()
        dealsBool = deals ?? false
        radiusEnum = radius ?? YelpDistance.auto
        sortModeEnum = sortMode ?? YelpSortMode.bestMatched
        for (k, v) in categoriesStates {
            categoryStates[k] = v
        }
    }
}
