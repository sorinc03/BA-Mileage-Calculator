//
//  TierCell.swift
//  TPCalculator
//
//  Created by Sorin Cioban on 24/07/2014.
//  Copyright (c) 2014 Sorin Cioban. All rights reserved.
//

import UIKit

class TierCell: UITableViewCell {
	@IBOutlet var tierNameLabel: UILabel?
	@IBOutlet var tierImageView: UIImageView?
	
	init(style: UITableViewCellStyle, reuseIdentifier: String!) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	override func awakeFromNib() {
		
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
}
