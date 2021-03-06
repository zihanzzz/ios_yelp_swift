//
//  FiltersViewController.swift
//  Yelp
//
//  Created by James Zhou on 10/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilter filter:  Filter)
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    enum FilterSection: Int {
        case deal = 0, distance,sortBy, category
    }
    
    @IBOutlet weak var filtersTableView: UITableView!
    
    weak var delegate: FiltersViewControllerDelegate?
    
    var categories: [[String:String]]!
    
    var switchStates = [Int:Bool]()
    
    var sections = ["Deal", "Distance", "Sort By", "Category"]
    
    var distanceOptions = ["Auto", "0.3 miles", "1 mile", "5 miles", "20 miles"]
    
    var sortByOptions = ["Best Match", "Distance", "Ratings"]
    
    var filter: Filter?
    
    var filterCopy: Filter?
    
    var isDistanceSectionExpanded = false
    var isSortBySectionExpanded = false
    var isCategorySectionExpanded = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        categories = UIConstants.getYelpCategories()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UIConstants.configureNavBarStyle(forViewController: self)
        filtersTableView.dataSource = self
        filtersTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigations
    
    @IBAction func onCancelButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearchButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        delegate?.filtersViewController?(filtersViewController: self, didUpdateFilter: self.filterCopy!)
    }
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numOfRows = 0
        
        switch section {
        case FilterSection.deal.rawValue:
            numOfRows = 1
            break
        case FilterSection.distance.rawValue:
            if (isDistanceSectionExpanded) {
                numOfRows = distanceOptions.count
            } else {
                numOfRows = 1
            }
            break
        case FilterSection.sortBy.rawValue:
            if (isSortBySectionExpanded) {
                numOfRows = sortByOptions.count
            } else {
                numOfRows = 1
            }
            break
        case FilterSection.category.rawValue:
            if (isCategorySectionExpanded) {
                numOfRows = categories.count
            } else {
                numOfRows = 3
            }
            break
        default:
            break
        }
        return numOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case FilterSection.deal.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceCell", for: indexPath) as! ChoiceCell
            cell.choiceLabel.text = "Offering a Deal"
            let dealState = self.filterCopy?.dealsBool ?? false
            if (dealState) {
                cell.showDealSelectedImage()
            } else {
                cell.showDealDeselectedImage()
            }
            cell.selectionStyle = .none
            return cell
        case FilterSection.distance.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceCell", for: indexPath) as! ChoiceCell
            cell.selectionStyle = .none
            
            if (isDistanceSectionExpanded) {
                cell.choiceLabel.text = distanceOptions[indexPath.row]
                if (indexPath.row == self.filterCopy?.radiusEnum.rawValue) {
                    cell.showSelectImage()
                } else {
                    cell.hideSelectImage()
                }
            } else {
                let selectedValue = self.filterCopy?.radiusEnum.rawValue
                cell.choiceLabel.text = distanceOptions[selectedValue!]
                cell.showSelectImage()
            }
            
            return cell
        case FilterSection.sortBy.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceCell", for: indexPath) as! ChoiceCell
            cell.selectionStyle = .none
        
            if (isSortBySectionExpanded) {
                cell.choiceLabel.text = sortByOptions[indexPath.row]
                if (indexPath.row == self.filterCopy?.sortModeEnum.rawValue) {
                    cell.showSelectImage()
                } else {
                    cell.hideSelectImage()
                }
            } else {
                let selectedValue = self.filterCopy?.sortModeEnum.rawValue
                cell.choiceLabel.text = sortByOptions[selectedValue!]
                cell.showSelectImage()
            }
            
            return cell
        case FilterSection.category.rawValue:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceCell", for: indexPath) as! ChoiceCell
            cell.textLabel?.removeFromSuperview()
            cell.textLabel?.text = ""
            cell.choiceLabel.isHidden = false
            cell.hideSelectImage()
            cell.selectionStyle = .none
            
            if (indexPath.row < 2 || isCategorySectionExpanded) {
                cell.choiceLabel.text = categories[indexPath.row]["name"]
                let categoryState = self.filterCopy?.categoryStates[indexPath.row] ?? false
                if (categoryState) {
                    cell.showCategoryImage()
                }
            } else if (indexPath.row == 2 && !isCategorySectionExpanded) {
                cell.hideSelectImage()
                cell.choiceLabel.isHidden = true
                cell.textLabel?.text = "Tap to See All"
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.textColor = UIConstants.yelpDarkRed
                cell.textLabel?.font = UIFont(name: UIConstants.getTextFontNameBold(), size: 25)
            }
            
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case FilterSection.deal.rawValue:
            let dealCell = tableView.cellForRow(at: indexPath) as! ChoiceCell
            let dealState = self.filterCopy?.dealsBool ?? false
            if (!dealState) {
                dealCell.showDealSelectedImage()
            } else {
                dealCell.showDealDeselectedImage()
            }
            self.filterCopy?.dealsBool = !dealState
            break
        case FilterSection.distance.rawValue:
            
            if isDistanceSectionExpanded {
                let selectedRow = indexPath.row
                self.filterCopy?.radiusEnum = YelpDistance(rawValue: selectedRow)
            }
            
            isDistanceSectionExpanded = !isDistanceSectionExpanded
            self.filtersTableView.reloadSections(IndexSet.init(integer: FilterSection.distance.rawValue), with: .automatic)
            break
        case FilterSection.sortBy.rawValue:
            
            if isSortBySectionExpanded {
                let selectedRow = indexPath.row
                self.filterCopy?.sortModeEnum = YelpSortMode(rawValue: selectedRow)
            }
            
            isSortBySectionExpanded = !isSortBySectionExpanded
            self.filtersTableView.reloadSections(IndexSet.init(integer: FilterSection.sortBy.rawValue), with: .automatic)
            break
        
        case FilterSection.category.rawValue:
            
            if (!isCategorySectionExpanded) {
                let selectedRow = indexPath.row
                if (selectedRow == 2) {
                    isCategorySectionExpanded = !isCategorySectionExpanded
                    self.filtersTableView.reloadSections(IndexSet.init(integer: FilterSection.category.rawValue), with: .automatic)
                }
            } else {
                let categoryState = self.filterCopy?.categoryStates[indexPath.row] ?? false
                let categoryCell = tableView.cellForRow(at: indexPath) as! ChoiceCell
                if (categoryState) {
                    categoryCell.hideSelectImage()
                } else {
                    categoryCell.showCategoryImage()
                }
                self.filterCopy?.categoryStates[indexPath.row] = !categoryState
            }
            
            break
        default:
            break
        }
    }
}
