//
//  SCTravelClassViewController.h
//  TPCalculator
//
//  Created by Sorin Cioban on 01/03/2014.
//  Copyright (c) 2014 Sorin Cioban. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCFareCell;

@interface SCTravelClassViewController : UITableViewController

@property (nonatomic, strong) NSArray *fareNames;
@property (nonatomic, strong) NSArray *fareCodes;
@property (nonatomic, assign) id delegate;

@end

@protocol FareSegue <NSObject>

- (void)travelClassViewController:(SCTravelClassViewController *)viewController didSelectFareCode:(NSString *)code;

@end