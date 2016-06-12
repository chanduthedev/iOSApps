//
//  CyberSecurityCellViewController.m
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 19/05/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import "CyberSecurityCellViewController.h"
#import "SWRevealViewController.h"

@interface CyberSecurityCellViewController ()

@end

@implementation CyberSecurityCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *fullURL = @"http://www.cyberabadsecuritycouncil.org/";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webview loadRequest:requestObj];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
