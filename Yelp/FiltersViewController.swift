//
//  FiltersViewController.swift
//  Yelp
//
//  Created by James Zhou on 10/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject])
    @objc optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilter filter:  Filter)
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate {
    
    @IBOutlet weak var filtersTableView: UITableView!
    
    weak var delegate: FiltersViewControllerDelegate?
    
    var categories: [[String:String]]!
    
    var switchStates = [Int:Bool]()
    
    var sections = ["Deal", "Distance", "Sort By", "Category"]
    
    var distanceOptions = ["Auto", "0.3 miles", "1 mile", "5 miles", "20 miles"]
    
    var sortByOptions = ["Best Match", "Distance", "Ratings"]
    
    var filter: Filter?
    
    var filterCopy: Filter?
    
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
        case 0:
            numOfRows = 1
            break
        case 1:
            numOfRows = 5
            break
        case 2:
            numOfRows = 3
            break
        case 3:
            numOfRows = categories.count
            break
        default:
            break
        }
        return numOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
            cell.switchLabel.text = "Offering a Deal"
            cell.delegate = self
            cell.onSwitch.isOn = self.filterCopy?.dealsBool ?? false
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceCell", for: indexPath) as! ChoiceCell
            cell.choiceLabel.text = distanceOptions[indexPath.row]
            cell.selectionStyle = .none
            if (indexPath.row == self.filterCopy?.radiusEnum.rawValue) {
                cell.showSelectImage()
            } else {
                cell.hideSelectImage()
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceCell", for: indexPath) as! ChoiceCell
            cell.choiceLabel.text = sortByOptions[indexPath.row]
            cell.selectionStyle = .none
            if (indexPath.row == self.filterCopy?.sortModeEnum.rawValue) {
                cell.showSelectImage()
            } else {
                cell.hideSelectImage()
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
            cell.switchLabel.text = categories[indexPath.row]["name"]
            cell.delegate = self
            cell.onSwitch.isOn = self.filterCopy?.categoryStates[indexPath.row] ?? false
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            let selectedRow = indexPath.row
            self.filterCopy?.radiusEnum = YelpDistance(rawValue: selectedRow)
            self.filtersTableView.reloadData()
            break
        case 2:
            let selectedRow = indexPath.row
            self.filterCopy?.sortModeEnum = YelpSortMode(rawValue: selectedRow)
            self.filtersTableView.reloadData()
        default:
            break
        }
    }
    
    // MARK: - SwitchCell Delegate method
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = filtersTableView.indexPath(for: switchCell)!
        if (indexPath.section == 0) {
            self.filterCopy?.dealsBool = value
        } else if (indexPath.section == 3) {
            switchStates[indexPath.row] = value
            self.filterCopy?.categoryStates = switchStates
        }
    }
}
