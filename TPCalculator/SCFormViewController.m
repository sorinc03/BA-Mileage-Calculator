//
//  SCFormViewController.m
//  TPCalculator
//
//  Created by Sorin Cioban on 01/03/2014.
//  Copyright (c) 2014 Sorin Cioban. All rights reserved.
//

#import "SCFormViewController.h"
#import "SCFormCell.h"
#import "SCTierViewController.h"
#import "SCTravelClassViewController.h"
#import "SCAirlineViewController.h"

#define kFormDetailCellIdentifier @"FormDetailCell"
#define kFormEditCellIdentifier @"FormEditCell"
#define kBAFlightCalculatorURL @"http://www.britishairways.com/travel/flight-calculator/public/en_gb"

typedef void (^ResponseBlock)(NSData *data, NSURLResponse *response, NSError *error);

@interface SCFormViewController () <TierSegue, AirlineSegue, FareSegue, UITextFieldDelegate>

@property (nonatomic, strong) NSArray *formTitles;
@property (nonatomic, strong) NSDictionary *airlineDetails;
@property (nonatomic, strong) NSString *selectedAirline;
@property (nonatomic, strong) NSString *fareCode;

@end

@implementation SCFormViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.formTitles = @[@"BA Tier", @"Airline", @"Origin", @"Destination", @"Class"];
	
	NSError *error = nil;
	
	NSString *jsonString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Airlines" ofType:nil]encoding:NSUTF8StringEncoding error:&error];
	
	if (error) {
		
	} else {
		NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
		self.airlineDetails = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.formTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *identifier = [self canEditCellAtIndexPath:indexPath] ? kFormEditCellIdentifier : kFormDetailCellIdentifier;
	
	SCFormCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
	
	cell.propertyTitle.attributedText = [[NSAttributedString alloc] initWithString:self.formTitles[indexPath.row]];
	
    return cell;
}

- (BOOL)canEditCellAtIndexPath:(NSIndexPath *)indexPath {
	return indexPath.row == [self.formTitles indexOfObject:@"Origin"] || indexPath.row == [self.formTitles indexOfObject:@"Destination"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (indexPath.row == 0) {
		[self performSegueWithIdentifier:@"TierSegue" sender:nil];
	} else if (indexPath.row == 1) {
		[self performSegueWithIdentifier:@"AirlineSegue" sender:nil];
	} else if (indexPath.row == 4) {
		[self performSegueWithIdentifier:@"ClassSegue" sender:nil];
	}
}

#pragma mark - Form Detail Delegates

- (void)tierViewController:(SCTierViewController *)viewController didSelectTier:(NSString *)tier {
	
}

- (void)airlineViewController:(SCAirlineViewController *)viewController didSelectAirline:(NSString *)airline {
	self.selectedAirline = airline;
}

- (void)travelClassViewController:(SCTravelClassViewController *)viewController didSelectFareCode:(NSString *)code {
	self.fareCode = code;
}

#pragma mark - NSURLSession Connection

- (IBAction)requestTierPointsAndAvios:(id)sender {
	NSString *departureAirport = @"LHR";
	NSString *arrivalAirport = @"SYD";
	NSString *airlineCode = @"BA";//self.airlineDetails[@"Airlines"][self.selectedAirline][@"Code"];
	NSString *fareCode = @"J";//self.fareCode;
	NSString *tier = @"Gold";
	
	NSString *urlString = [NSString stringWithFormat:@"%@?eId=199001&marketingAirline=%@&tier=%@&departureAirportFull=%@&departureAirport=%@&arrivalAirportFull=%@&arrivalAirport=%@&airlineClass=%@&Calculate+Avios+and+Tier+Points=Calculate+Avios+and+Tier+Points", kBAFlightCalculatorURL, airlineCode, tier, departureAirport, departureAirport, arrivalAirport, arrivalAirport, fareCode];
	
	NSURL *url = [NSURL URLWithString:urlString];
	
	NSError *error = nil;
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setHTTPMethod:@"POST"];
	
	if (!error) {
		NSURLSession *session = [NSURLSession sharedSession];
		
		ResponseBlock block = [self responseBlock];
		
		NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:block];
		
		[task resume];
	}
}

- (ResponseBlock)responseBlock {
	ResponseBlock block = ^(NSData *data, NSURLResponse *response, NSError *error) {
		if ([data length] > 0 && error == nil) {
			NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
			
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				[self searchStringForAviosAndTP:responseString];
			}];
			
		} else if ([data length] == 0 && error == nil) {
			//[self noNewData];
		} else if (error != nil && error.code == NSURLErrorTimedOut) {
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				//[self.delegate unableToDownload];
			}];
		} else if (error != nil){
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				//[self.delegate unableToDownload];
			}];
		};};
	
	return block;
}

- (void)searchStringForAviosAndTP:(NSString *)responseString {
	NSError *error = nil;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<td>[0-9]{1,6}</td>" options:NSRegularExpressionCaseInsensitive error:&error];
	
	if (error) {
		NSLog(@"%@", error);
	} else {
		NSArray *matches = [regex matchesInString:responseString options:0 range:NSMakeRange(0, responseString.length)];
		
		for (NSTextCheckingResult *result in matches) {
			NSString *string = [responseString substringToIndex:result.range.location+result.range.length-5];
			string = [string substringFromIndex:result.range.location+4];
			
			NSLog(@"%@", string);
		}
	}
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"TierSegue"]) {
		SCTierViewController *viewController = [segue destinationViewController];
		
		viewController.tiers = self.airlineDetails[@"Tiers"];
		viewController.delegate = self;
		
	} else if ([[segue identifier] isEqualToString:@"AirlineSegue"]) {
		NSArray *airlineNames = [[self.airlineDetails[@"Airlines"] allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
			return [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
		}];
		
		SCAirlineViewController *viewController = [segue destinationViewController];
		
		viewController.airlines = airlineNames;
		viewController.delegate = self;
		
	} else if ([[segue identifier] isEqualToString:@"ClassSegue"]) {
		SCTravelClassViewController *viewController = [segue destinationViewController];
		
		NSDictionary *airlineDictionary = self.airlineDetails[@"Airlines"][self.selectedAirline];
		
		viewController.fareNames = airlineDictionary[@"Classes"];
		viewController.fareCodes = airlineDictionary[@"Fares"];
		viewController.delegate = self;
	}
}

@end
