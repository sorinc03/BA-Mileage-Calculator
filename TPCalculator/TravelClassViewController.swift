//
//  TravelClassViewController.swift
//  TPCalculator
//
//  Created by Sorin Cioban on 24/07/2014.
//  Copyright (c) 2014 Sorin Cioban. All rights reserved.
//

import UIKit

@objc protocol TravelClassViewControllerDelegate {
	func travelClassViewController(controller: TravelClassViewController, didSelectFareCode code:String!)
}

class TravelClassViewController: UITableViewController {
	var fareNames: [String] = []
	var fareCodes: [String] = []
	
	weak var delegate: TravelClassViewControllerDelegate?
	
	init(style: UITableViewStyle) {
		super.init(style: style)
	}
	
	init(coder aDecoder: NSCoder!) {
		super.init(coder: aDecoder)
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
		return self.fareCodes.count
	}
	
	override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
		var cell: FareCell = tableView.dequeueReusableCellWithIdentifier(kFareCellIdentifier, forIndexPath: indexPath) as FareCell
		
		if let label = cell.fareCodeLabel {
			label.attributedText = NSAttributedString(string: self.fareCodes[indexPath.row])
		}
		
		if let label = cell.travelClassNameLabel {
			label.attributedText = NSAttributedString(string: self.fareNames[indexPath.row])
		}
		
		return cell
	}
	
	override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		
		self.delegate?.travelClassViewController(self, didSelectFareCode: self.fareCodes[indexPath.row])
	}
	
	override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
		return 44
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
		
	}
}