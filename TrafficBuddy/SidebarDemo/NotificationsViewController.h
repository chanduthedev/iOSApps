//
//  NotificationsViewController.h
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 29/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@property (weak, nonatomic) IBOutlet UITableView *notifications;
@end
