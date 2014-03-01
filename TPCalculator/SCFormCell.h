//
//  SCFormCell.h
//  TPCalculator
//
//  Created by Sorin Cioban on 01/03/2014.
//  Copyright (c) 2014 Sorin Cioban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCFormCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *propertyTitle;
@property (nonatomic, weak) IBOutlet UILabel *propertyValue;
@property (nonatomic, weak) IBOutlet UITextField *textField;

@end
