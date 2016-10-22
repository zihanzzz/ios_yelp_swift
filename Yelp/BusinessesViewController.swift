//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIViewControllerPreviewingDelegate, FiltersViewControllerDelegate, UISearchBarDelegate {
    
    var businesses: [Business]!
    
    var filteredBusinesses: [Business]!
    
    var searchBar: UISearchBar?
    
    @IBOutlet weak var businessTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIConstants.configureNavBarStyle(forViewController: self)
        
        if #available(iOS 9, *) {
            if (traitCollection.forceTouchCapability == UIForceTouchCapability.available) {
                registerForPreviewing(with: self, sourceView: self.businessTableView)
                // It's important that the sourceView is set to the tableView instead of self.view
                // Otherwise previewingContext.sourceRect will cause issues! (different coordinate system)
                // but don't self.businessTableView and self.view have the same frame? No they don't (different width and height)
            }
        }
        
        businessTableView.delegate = self
        businessTableView.dataSource = self
        businessTableView.rowHeight = UITableViewAutomaticDimension
        businessTableView.estimatedRowHeight = 120
        
        self.searchBar = UISearchBar()
        self.searchBar?.sizeToFit()
        self.navigationItem.titleView = self.searchBar
        self.searchBar?.delegate = self
        self.searchBar?.tintColor = UIConstants.yelpDarkRed
        self.searchBar?.barTintColor = UIConstants.yelpDarkRed
        self.searchBar?.searchBarStyle = .prominent
        self.searchBar?.isTranslucent = false
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.filteredBusinesses = businesses
            self.businesses = businesses
            self.businessTableView.reloadData()
            
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    // MARK: - TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredBusinesses != nil {
            return filteredBusinesses!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar?.resignFirstResponder()
//        let businessDetailsVC = BusinessDetailsViewController()
//        self.navigationController?.pushViewController(businessDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.business = filteredBusinesses[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - 3D Touch Preview
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = self.businessTableView.indexPathForRow(at: location) else {return nil}
        guard let cell = self.businessTableView.cellForRow(at: indexPath) else {return nil}
                
        previewingContext.sourceRect = cell.frame

        let vc = BusinessMapViewController()
        vc.business = businesses[indexPath.row]
        
        let preferredWidth = self.view.frame.size.width - 50
        vc.preferredContentSize = CGSize(width: preferredWidth, height: preferredWidth)

        return vc
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        // do nothing --> do not present the actual view controller
    }
    
    // MARK: - Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty) {
            self.filteredBusinesses = self.businesses
        } else {
            // The user has entered text into the search box
            // Use the filter method to iterate over all items in the data array
            // For each item, return true if the item should be included and false if the
            // item should NOT be included
            
            self.filteredBusinesses = self.businesses.filter({ (business: Business) -> Bool in
                
                if business.name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil {
                    return true
                } else {
                    return false
                }
            })
        }
        self.businessTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        // Do a network API call here
        if (searchBar.text != nil) {
            Business.searchWithTerm(term: searchBar.text!) { (businesses, error) in
                self.businesses = businesses
                self.filteredBusinesses = businesses
                self.businessTableView.reloadData()
            }
        }
    }
    // MARK: - Navigations related
    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController {
            if let fitersViewController = navigationController.topViewController as? FiltersViewController {
                fitersViewController.delegate = self
            }
        }

        if let businessDeatilsViewController = segue.destination as? BusinessDetailsViewController {
            if let businessCell = sender as? BusinessCell {
                businessDeatilsViewController.business = businessCell.business
            }
        }
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        let categories = filters["categories"] as? [String]
        Business.searchWithTerm(term: "Restaurants", sort: nil, categories: categories, deals: nil) { (businesses, error) in
            self.businesses = businesses
            self.filteredBusinesses = businesses
            self.businessTableView.reloadData()
        }
    }
}
