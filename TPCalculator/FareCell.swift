//
//  FareCell.swift
//  TPCalculator
//
//  Created by Sorin Cioban on 24/07/2014.
//  Copyright (c) 2014 Sorin Cioban. All rights reserved.
//

import UIKit

class FareCell: UITableViewCell {
	@IBOutlet var travelClassNameLabel: UILabel?
	@IBOutlet var fareCodeLabel: UILabel?
	
	init(style: UITableViewCellStyle, reuseIdentifier: String!) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	override func awakeFromNib() {
		
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
}