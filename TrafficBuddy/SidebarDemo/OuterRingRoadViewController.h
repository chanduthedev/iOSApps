//
//  OuterRingRoadViewController.h
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 19/05/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import "ViewController.h"

@interface OuterRingRoadViewController : ViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *orrHelpLine;
@property (weak, nonatomic) IBOutlet UIImageView *orrImage;
@property (weak, nonatomic) IBOutlet UILabel *orrInfo;
@end
