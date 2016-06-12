//
//  PoliceStationViewController.h
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 21/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface PoliceStationViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextView *psContactDetails;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
