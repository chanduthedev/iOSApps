//
//  PhotoViewController.h
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 21/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) NSString *photoFilename;
@end
