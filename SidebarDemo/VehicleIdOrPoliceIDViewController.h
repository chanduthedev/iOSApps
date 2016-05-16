//
//  VehicleIdOrPoliceIDViewController.h
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 29/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehicleIdOrPoliceIDViewController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (weak, nonatomic) IBOutlet UITextField *vehicleNo;
@property (weak, nonatomic) IBOutlet UITextField *policeIDNo;
@property (nonatomic, strong) NSDictionary *vehicleDetails;
- (IBAction)getCabDetails:(id)sender;

@end
