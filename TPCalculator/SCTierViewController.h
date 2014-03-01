//
//  SCTierViewController.h
//  TPCalculator
//
//  Created by Sorin Cioban on 01/03/2014.
//  Copyright (c) 2014 Sorin Cioban. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCTierCell;

@interface SCTierViewController : UITableViewController

@property (nonatomic, strong) NSArray *tiers;
@property (nonatomic, assign) id delegate;

@end

@protocol TierSegue <NSObject>

- (void)tierViewController:(SCTierViewController *)viewController didSelectTier:(NSString *)tier;

@end
