//
//  PoliceStationViewController.m
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 21/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import "PoliceStationViewController.h"
#import "Annotations.h"
#import "SWRevealViewController.h"
#import "Utils.h"

//#define india_lat 17.44822696
//#define india_lon 78.37071863

@interface PoliceStationViewController ()

@end

@implementation PoliceStationViewController
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    
    locationManager.delegate = self;
    self.mapView.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    [locationManager startUpdatingLocation];
    
    //MKCoordinateRegion myRegion;
    
    //myRegion.center = center;
    //myRegion.span = span;
    
    
    
    NSArray *annotationsData =  [Utils getPSGeoDetails];
    [self.mapView addAnnotations:annotationsData];
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


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"in didUpdateToLocation  ");
    CLLocation *currentLocation = newLocation;
    
    CLLocationCoordinate2D center;
    if (currentLocation != nil) {
        center.latitude = currentLocation.coordinate.latitude;
        center.longitude =currentLocation.coordinate.longitude;
    }
    
    
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(center, 2000, 2000)];
    [self.mapView setRegion:adjustedRegion animated:YES];

//    NSLog(@"didUpdateToLocation: %@", newLocation);
//    CLLocation *currentLocation = newLocation;
//    
//    if (currentLocation != nil) {
//        NSString *lon = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
//        NSString *lat = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
//        NSLog(@"lat is %@", lat);
//        NSLog(@"lon is %@", lon);
//    }
//    
//    // Reverse Geocoding
//    NSLog(@"Resolving the Address");
//    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//       // NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
//        if (error == nil && [placemarks count] > 0) {
//            placemark = [placemarks lastObject];
//            NSString *add = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
//                                 placemark.subThoroughfare, placemark.thoroughfare,
//                                 placemark.postalCode, placemark.locality,
//                                 placemark.administrativeArea,
//                                 placemark.country];
//            NSLog(@"address is %@", add);
//        } else {
//            NSLog(@"%@", error.debugDescription);
//        }
//    } ];
//    
    [locationManager stopUpdatingLocation];
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"in annotationView");
    id <MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        NSLog(@"Clicked Pizza Shop");
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Disclosure Pressed" message:@"Click Cancel to Go Back" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertView show];
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    Annotations *dmAnn = (Annotations *)view.annotation;
    NSString *psID = dmAnn.psID;
    
    //NSLog(@"psID is %@", psID);

    NSString *name = [psID stringByReplacingOccurrencesOfString:@"'" withString:@""];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
    NSError *error;
//    NSString *content = [NSString stringWithContentsOfFile:path
//                                  encoding:NSUTF8StringEncoding error:&error];
//    
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSMacOSRomanStringEncoding error:&error];
    
    NSLog(@"Error is %@", error);
    
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [content dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil
                                            ];
//    self.psContactDetails.attributedText = [Utils getHtmlString:content];
    self.psContactDetails.attributedText = attributedString;

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        NSLog(@"annotation is  MKUserLocation class");
        return nil;
    }
    
//    MKAnnotationView *annotationView=[mapView dequeueReusableAnnotationViewWithIdentifier:@"test"];
//    //If one isn't available, create a new one
//    if(!annotationView){
//        annotationView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"test"];
//        annotationView.annotation = annotation;
//        //[string rangeOfString:@"bla"].location == NSNotFound
//        NSString *title = [((Annotations *)annotation) title];
//        if([title rangeOfString:@"Traffic" ].location != NSNotFound){
//            annotationView.image=[UIImage imageNamed:@"tps.png"];
//        } else {
//            annotationView.image=[UIImage imageNamed:@"ps.png"];
//        }
//        NSLog(@"Ttile is %@", [annotationView.annotation title]);
//        
//        //annotationView.image=[UIImage imageNamed:@"ps.png"];
//        
//        return annotationView;
//    }

    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        NSLog(@"annotation is  MKPointAnnotation class");
        // Try to dequeue an existing pin view first.
        MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Annotations"];
        if (!pinView)
        {
            NSLog(@"not using dequeue!!");
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Annotations"];
            pinView.canShowCallout = YES;
           pinView.image = [UIImage imageNamed:@"ps.png"];
            pinView.calloutOffset = CGPointMake(0, 32);
            
            // Add a detail disclosure button to the callout.
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            pinView.rightCalloutAccessoryView = rightButton;
            
            // Add an image to the left callout.
//            UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pizza_slice_32.png"]];
//            pinView.leftCalloutAccessoryView = iconView;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    
    
    //NSLog(@"leaving viewForAnnotation");
    return nil;
}
@end
