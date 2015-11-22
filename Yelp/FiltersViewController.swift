//
//  FiltersViewController.swift
//  Yelp
//
//  Created by HV Fenrir on 11/21/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit
@objc protocol FiltersViewControllerDelegate{
    optional func filtersViewController(filtersViewController: FiltersViewController, didUpdatefilters filters: [String:AnyObject])
}


class FiltersViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, SwitchCellDelegate ,UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
        "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
        "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
        "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
        "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    var switchStates = [Int:Bool]()
    var filteredData: [String]!
    
    
    weak var delegate: FiltersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        filteredData = data
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return filteredData.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell") as! SwitchCell
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
//        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
//        cell.switchLabel.text = data[indexPath.row]
//        cell.delegate = self
////        if switchStates[indexPath.row] != nil{
////            cell.onSwitch.on = switchStates[indexPath.row]!
////        }else{
////            cell.onSwitch.on = false
////        }
//        
//        cell.onSwitch.on = switchStates[indexPath.row] ?? false
//        
//        return cell
//    }

    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(switchCell)
        switchStates[indexPath!.row] = value
    }
    
    @IBAction func onCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSearchButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        var filters = [String : AnyObject]()
        var selectedCategories = [String]()
        for(row,isSelected) in switchStates{
            if isSelected{
                selectedCategories.append(data[row])
            }
            
        }
        if selectedCategories.count > 0{
            filters["categories"] = selectedCategories
        }
        delegate?.filtersViewController?(self, didUpdatefilters: filters)
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
        })
        
        tableView.reloadData()
    }    
}
