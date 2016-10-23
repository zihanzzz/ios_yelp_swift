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
    
    var categoriesArray: [String]!
    
    init(deals: Bool?, radius: YelpDistance?, sortMode: YelpSortMode?, categories: [String]?) {
        super.init()
        dealsBool = deals ?? false
        radiusEnum = radius ?? YelpDistance.auto
        sortModeEnum = sortMode ?? YelpSortMode.bestMatched
        categoriesArray = categories ?? [String]()
    }
}
