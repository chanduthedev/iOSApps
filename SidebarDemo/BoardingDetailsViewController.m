//
//  BoardingDetailsViewController.m
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 28/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import "BoardingDetailsViewController.h"
#import "SWRevealViewController.h"
#import "Utils.h"

@interface BoardingDetailsViewController ()

@end

@implementation BoardingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.navigationItem setHidesBackButton:YES];
    SWRevealViewController *revealViewController = self.revealViewController;
    
    self.boardingDetails.text = [NSString stringWithFormat:@"Cab boarding Time: %@\nPolice Indentificaiton NO: %@\nVehicle/DL No: %@",[Utils getCurrentTime], @"", @""];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
