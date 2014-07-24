//
//  SCAirlineViewController.h
//  TPCalculator
//
//  Created by Sorin Cioban on 01/03/2014.
//  Copyright (c) 2014 Sorin Cioban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCAirlineViewController : UITableViewController

@property (nonatomic, strong) NSArray *airlines;
@property (nonatomic, assign) id delegate;

@end

@protocol AirlineSegue <NSObject>

- (void)airlineViewController:(SCAirlineViewController *)viewController didSelectAirline:(NSString *)airline;

@end