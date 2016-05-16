//
//  StarRatingViewController.h
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 28/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarRatingViewController : UIViewController
{
    NSArray *ratingNames;
    NSArray *starButtons;
}
@property (weak, nonatomic) IBOutlet UILabel *ratingName;
- (IBAction)starRating:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *starOne;
@property (weak, nonatomic) IBOutlet UIButton *starTwo;
@property (weak, nonatomic) IBOutlet UIButton *starThree;
@property (weak, nonatomic) IBOutlet UIButton *starFour;
@property (weak, nonatomic) IBOutlet UIButton *starFive;
- (IBAction)reviewSubmit:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@end
