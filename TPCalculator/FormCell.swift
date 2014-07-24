//
//  FormCell.swift
//  TPCalculator
//
//  Created by Sorin Cioban on 24/07/2014.
//  Copyright (c) 2014 Sorin Cioban. All rights reserved.
//

import UIKit

class FormCell: UITableViewCell {
	@IBOutlet var propertyTitle: UILabel?
	@IBOutlet var propertyValue: UILabel?
	@IBOutlet var textField: UITextField?
	
	init(style: UITableViewCellStyle, reuseIdentifier: String!) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	override func awakeFromNib() {
		
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
}