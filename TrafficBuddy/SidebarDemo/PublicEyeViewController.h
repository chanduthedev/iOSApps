//
//  PublicEyeViewController.h
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 18/05/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import "ViewController.h"
#import "AccountKit/AccountKit.h"
#import <MapKit/MapKit.h>

@interface PublicEyeViewController : ViewController <UITableViewDelegate, UITableViewDataSource,UITextViewDelegate, AKFViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    AKFAccountKit *_accountKit;
    UIViewController<AKFViewController> *_pendingLoginViewController;
    NSString *_authorizationCode;
}
@property (weak, nonatomic) IBOutlet UIButton *selectedCategory;
- (IBAction)selectCategory:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *categories;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@property (strong, nonatomic) NSArray *categoryTypes;

- (IBAction)upLoadImage:(id)sender;
- (IBAction)submitIncident:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *comments;
@property (strong, nonatomic) IBOutlet UIImage *selectedImage;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
