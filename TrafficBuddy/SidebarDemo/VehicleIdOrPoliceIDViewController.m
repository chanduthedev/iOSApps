//
//  VehicleIdOrPoliceIDViewController.m
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 29/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import "VehicleIdOrPoliceIDViewController.h"
#import "SWRevealViewController.h"
#import "network.h"
#import "Utils.h"
#import "CabDetailsViewController.h"

#define VEHICLE_URL @"http://police.nayalabs.com/api/cab_registrations/get_vehicle_details_by_vehicle_no"
#define POLICEID_URL @"http://police.nayalabs.com/api/cab_registrations/get_vehicle_details_by_police_id_no"


@interface VehicleIdOrPoliceIDViewController ()

@end

@implementation VehicleIdOrPoliceIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vehicleNo.delegate = self;
    self.policeIDNo.delegate =  self;
    //[self.navigationItem setHidesBackButton:YES];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    
    CabDetailsViewController *cdVC = (CabDetailsViewController*)[segue destinationViewController];
    cdVC.vehicleDetails = self.vehicleDetails;
    NSLog(@"navigating to CabDetailsViewController");
    // Pass the selected object to the new view controller.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
}

- (IBAction)getCabDetails:(id)sender {
    network *instance = [network sharedManager];
    if(![instance isNetworkAvailable]){
        [Utils displayAlert:@"Network is not availble" displayText:@"Please check your network connection"];
        return;
    }
    
    NSLog(@"need to implement API call here!!");
    if(![Utils checkVehiclNoNPoliceID:self.vehicleNo.text policeID:self.policeIDNo.text]){
        NSLog(@"in getCabDetails not valid input details");
        return;
    }
    NSString *inputStr;
    NSString *url;
    if(![Utils isEmptyString:self.vehicleNo.text]){
        inputStr = self.policeIDNo.text;
        url = POLICEID_URL;
    }else{
        inputStr = self.vehicleNo.text;
        url = VEHICLE_URL;
    }
    NSMutableDictionary *params =[[NSMutableDictionary alloc] init];
    //@"vehicle_no=%@&police_id_no=%@&device_no=%@&imei_no=%@"
    params[@"vehicle_no"]=inputStr;
    params[@"police_id_no"]=inputStr;
    params[@"device_no"]=@"testing";
    params[@"imei_no"]=@"testing";
    self.vehicleDetails = [instance getCabDetails:url params:params completionHandle:^(id response){
        NSLog(@"reponse is %@", response);
                if([instance isCabDetailsValid:response]){
                    NSLog(@"navigating 2 cabDetailView");
                    self.vehicleDetails = response;
                        [self performSegueWithIdentifier:@"cabDetailsView" sender:nil];
                } else{
                    [Utils displayAlert:@"" displayText:[response objectForKey:@"message"]];
                    NSLog(@"response is %@", [response objectForKey:@"message"]);
                }
    }];
}


@end
