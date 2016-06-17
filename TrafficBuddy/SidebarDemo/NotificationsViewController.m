//
//  NotificationsViewController.m
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 29/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import "NotificationsViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"

@interface NotificationsViewController ()

@end

@implementation NotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.notifications.delegate = self;
    self.notifications.dataSource = self;

    [self.notifications reloadData];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    AppDelegate *sharedApp = ((AppDelegate*)[[UIApplication sharedApplication]delegate]);
    return [sharedApp.recentTrafficUpdates count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    // Reuse and create cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    AppDelegate *sharedApp = ((AppDelegate*)[[UIApplication sharedApplication]delegate]);
    cell.textLabel.text = [sharedApp.recentTrafficUpdates objectAtIndex:indexPath.row];
    
    return cell;
}

@end
