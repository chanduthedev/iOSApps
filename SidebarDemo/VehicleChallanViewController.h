//
//  VehicleChallanViewController.h
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 21/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "network.h"
@interface VehicleChallanViewController : UIViewController<UITextFieldDelegate>
{
    network *nw;
    void (^_completionHandler)(NSArray *response);
}
@property (weak, nonatomic) IBOutlet UILabel *vehicleNoStrlen;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITextField *vehicleNo;
- (IBAction)getChalanDetails:(id)sender;

- (IBAction)editingChanged:(id)sender;
- (IBAction)editingEnd:(id)sender;

- (void)setKeyBoardType:(int)pos;
@end
