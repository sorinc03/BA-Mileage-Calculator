//
//  TierViewController.swift
//  TPCalculator
//
//  Created by Sorin Cioban on 24/07/2014.
//  Copyright (c) 2014 Sorin Cioban. All rights reserved.
//

import UIKit

@objc protocol TierViewControllerDelegate {
	func tierViewController(controller: TierViewController, didSelectTier tier:String!)
}

class TierViewController: UITableViewController {
	var tiers: [String] = []
	
	weak var delegate: TierViewControllerDelegate?
	
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
		return self.tiers.count
	}
	
	override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
		var cell: TierCell = tableView.dequeueReusableCellWithIdentifier(kTierCellIdentifier, forIndexPath: indexPath) as TierCell
		
		if let label = cell.tierNameLabel {
			label.attributedText = NSAttributedString(string: self.tiers[indexPath.row])
		}
		
		return cell
	}
	
	override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		
		self.delegate?.tierViewController(self, didSelectTier: self.tiers[indexPath.row])
	}
	
	override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
		return 44
	}

	override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
		
	}
}
