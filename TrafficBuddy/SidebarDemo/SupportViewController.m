//
//  SupportViewController.m
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 12/05/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import "SupportViewController.h"
#import "Utils.h"
#import "SWRevealViewController.h"

@interface SupportViewController ()

@end

@implementation SupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    // Do any additional setup after loading the view.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"support" ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding error:nil];
    self.supportInfo.attributedText = [Utils getHtmlString:content];
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
