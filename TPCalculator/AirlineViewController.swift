//
//  AirlineViewController.swift
//  TPCalculator
//
//  Created by Sorin Cioban on 24/07/2014.
//  Copyright (c) 2014 Sorin Cioban. All rights reserved.
//

import UIKit

@objc protocol AirlineViewControllerDelegate {
	func airlineViewController(controller: AirlineViewController, didSelectAirline airline:String!)
}

class AirlineViewController: UITableViewController {
	var airlines: [String] = []
	
	weak var delegate: AirlineViewControllerDelegate?
	
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
		return self.airlines.count
	}
	
	override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
		var cell: AirlineCell = tableView.dequeueReusableCellWithIdentifier(kAirlineCellIdentifier, forIndexPath: indexPath) as AirlineCell
		
		if let label = cell.airlineNameLabel {
			label.attributedText = NSAttributedString(string: self.airlines[indexPath.row])
		}
		
		return cell
	}
	
	override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		
		self.delegate?.airlineViewController(self, didSelectAirline: self.airlines[indexPath.row])
	}
	
	override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
		return 44
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
		
	}
}
