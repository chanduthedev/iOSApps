//
//  ChallanDetailsTableViewController.h
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 21/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChallanDetailsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *dates;
    NSArray *reasons;
}
@property (strong, nonatomic) IBOutlet UITableView *myTable;

@end
