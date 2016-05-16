//
//  CabDetailsViewController.h
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 26/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CabDetailsViewController : UIViewController
{
    NSArray *cabDetails;
}

- (IBAction)notTravelling:(id)sender;
@property (nonatomic, strong) NSString *cabDetails;
@property (nonatomic, strong) NSDictionary *vehicleDetails;
@property (weak, nonatomic) IBOutlet UILabel *cabDetailsLbl;
@property (weak, nonatomic) IBOutlet UITextView *cabDetailsTxtView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@end
