//
//  FormViewController.swift
//  TPCalculator
//
//  Created by Sorin Cioban on 24/07/2014.
//  Copyright (c) 2014 Sorin Cioban. All rights reserved.
//

import UIKit

class FormViewController: UITableViewController, TierViewControllerDelegate, AirlineViewControllerDelegate, TravelClassViewControllerDelegate, UITextFieldDelegate {
	
	var formTitles: [String] = []
	var resultTitles: [String] = []
	var airlineDetails = Dictionary<String, String>()
	var selectedAirline: String?
	var fareCode: String?
	var tier: String?
	var departureAirport: String?
	var arrivalAirport: String?
	var tierPoints: String?
	var avios: String?
	
	override func viewDidLoad() {
		self.formTitles = ["BA Tier", "Airline", "Origin", "Destination", "Class"]
		self.resultTitles = ["Avios", "Tier Points"]
		
		self.tier = "Blue"
		self.fareCode = "G"
		self.selectedAirline = "British Airways"
		self.departureAirport = "LHR"
		self.arrivalAirport = "JFK"
		self.tierPoints = "0"
		self.avios = "0"
		
		var error: NSError?
		
		let jsonString = NSString.stringWithContentsOfFile(NSBundle.mainBundle().pathForResource("Airlines", ofType: nil), encoding: NSUTF8StringEncoding, error: &error)
		
		if error {
			
		} else {
			let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
			
			self.airlineDetails = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.fromRaw(0)!, error: &error) as Dictionary<String, String>
		}
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
		return 2
	}
	
	override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
		switch section {
			case 0: return self.formTitles.count
			default: return 2
		}
	}
	
	override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
		var identifier = kFormDetailCellIdentifier
		
		if self.canEditCellAtIndexPath(indexPath) == true {
			identifier = kFormEditCellIdentifier
		}
		
		var cell: FormCell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as FormCell
		
		if indexPath.section == 0 {
			cell.selectionStyle = .Default
			
			if let propertyLabel = cell.propertyTitle {
				propertyLabel.attributedText = NSAttributedString(string: self.formTitles[indexPath.row])
			}

			if let textField = cell.textField {
				textField.tag = indexPath.row
			}
			
			if let propertyValueLabel = cell.propertyValue {
				var propertyValue = ""
				switch indexPath.row {
					case 0: propertyValue = self.tier!
					case 1: propertyValue = self.selectedAirline!
					case 4: propertyValue = self.fareCode!
					default: propertyValue = ""
				}
				
				propertyValueLabel.attributedText = NSAttributedString(string: propertyValue)
			}
		
			if self.canEditCellAtIndexPath(indexPath) == true {
				cell.selectionStyle = .None
			}
		}
		
		else if indexPath.section == 1 {
			cell.selectionStyle = .None
			
			if let propertyTitle = cell.propertyTitle {
				propertyTitle.attributedText = NSAttributedString(string: self.resultTitles[indexPath.row])
			}
			
			var value = self.avios
			
			if indexPath.row == 1 {
				value = self.tierPoints
			}
			
			if let propertyValue = cell.propertyValue {
				propertyValue.attributedText = NSAttributedString(string: value)
			}
		}
		
		return cell
	}
	
	func canEditCellAtIndexPath(indexPath: NSIndexPath!) -> Bool {
		for index in 0..<self.formTitles.count {
			if self.formTitles[index] == "Origin" || self.formTitles[index] == "Destination" {
				return true
			}
		}
		
		return false
	}
	
	override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		
		if indexPath.section == 0 {
			var identifier = ""
			
			switch indexPath.row {
				case 0: identifier = "TierSegue"
				case 1: identifier = "AirlineSegue"
				case 4: identifier = "ClassSegue"
				default: identifier = ""
			}
			
			self.performSegueWithIdentifier(identifier, sender: nil)
		}
	}
	
	func tierViewController(controller: TierViewController, didSelectTier tier: String!) {
		self.tier = tier
		controller.navigationController .popViewControllerAnimated(true)
	
	}
	
	func airlineViewController(controller: AirlineViewController, didSelectAirline airline: String!) {
		self.selectedAirline = airline
		
//		self.fareCode = self.airlineDetails["Airlines"][airline]["Fares"][0]
		
	}
	
	func travelClassViewController(controller: TravelClassViewController, didSelectFareCode code: String!) {
		
	}
	
	override func didReceiveMemoryWarning() {
		
	}
}
