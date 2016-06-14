//
//  OuterRingRoadViewController.m
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 19/05/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import "OuterRingRoadViewController.h"
#import "SWRevealViewController.h"
#import "Utils.h"

@interface OuterRingRoadViewController ()

@end

@implementation OuterRingRoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"outerringroadhelpline" ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding error:nil];
    self.orrHelpLine.attributedText = [Utils getHtmlString:content];
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"outerringroad" ofType:@"txt"];
    NSString *content1 = [NSString stringWithContentsOfFile:path1
                                                  encoding:NSUTF8StringEncoding error:nil];
    self.orrInfo.attributedText = [Utils getHtmlString:content1];
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
