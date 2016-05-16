//
//  VehicleChallanViewController.m
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 21/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import "VehicleChallanViewController.h"
#import "network.h"
#import "SWRevealViewController.h"

#define VEHICLE_NO_LENGTH   10
@interface VehicleChallanViewController ()

@end

@implementation VehicleChallanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vehicleNo.delegate = self;
    nw = [[network alloc] init];
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)getChalanDetails:(id)sender {
    
    [self getVehicleDetails];    

//    [nw getChallansFortheVehicle:@"" vehicleN:@"" deviceNo:@"" imeiNo:@"" completionHandle:^(NSArray * response){
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Challan status" message:@"You have no challans" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
//
//        if([response count]){
//                [self performSegueWithIdentifier:@"showChallanViewController" sender:nil];
//        }
//        else{
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Challan status" message:@"You have no challans" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
//        }
//    }];
}


- (void)setKeyBoardType:(int)pos{
    if([self.vehicleNo.text length] == 2){
        [self.vehicleNo setKeyboardType:UIKeyboardTypeNumberPad];
    }
    if([self.vehicleNo.text length] == 4){
        [self.vehicleNo setKeyboardType:UIKeyboardTypeDefault];
    }
    if([self.vehicleNo.text length] == 6){
        [self.vehicleNo setKeyboardType:UIKeyboardTypeNumberPad];
    }
    if([self.vehicleNo.text length] == 10){
        [self.vehicleNo setKeyboardType:UIKeyboardTypeDefault];
    }
    [self.vehicleNo reloadInputViews];
}

- (IBAction)editingChanged:(id)sender {
    
    NSLog(@"in editingChanged");
    [self setKeyBoardType:[self.vehicleNo.text length]];
    
    NSString *vehicleNo =  [NSString stringWithFormat:@"%d/10", [self.vehicleNo.text length] ];
    self.vehicleNoStrlen.text = vehicleNo;
    
}

- (void)getVehicleDetails {
    NSString *vehicleNo = self.vehicleNo.text;
    if (vehicleNo.length < VEHICLE_NO_LENGTH){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not a valid vehicle" message:@"Enter valid vehicle no" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Challan status" message:@"You have no challans" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)editingEnd:(id)sender {
    
    NSLog(@"in editingEnd");
    [self getVehicleDetails];
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([self.vehicleNo.text length] >= VEHICLE_NO_LENGTH){
        return NO;
    }
    return YES;
}
@end
