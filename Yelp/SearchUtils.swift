//
//  SearchUtils.swift
//  Yelp
//
//  Created by James Zhou on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class SearchUtils: NSObject {

    static func performSearchWith(filter: Filter?, offset: Int, completionHandler: @escaping ([Business]?, Error?) -> ()) {
        let searchTerm = "Restaurants"
        let radius = filter?.radiusEnum ?? YelpDistance.auto
        let sort = filter?.sortModeEnum ?? YelpSortMode.bestMatched
        let categories = UIConstants.getSelectedCategories(switchStates: filter?.categoryStates ?? [Int:Bool]())
        let deals = filter?.dealsBool ?? false
        Business.searchWithTerm(term: searchTerm, offset: offset, radius: radius, sort: sort, categories: categories, deals: deals) { (businesses, error) in
            completionHandler(businesses, error)
        }
    }
}
