//
//  StarRatingViewController.m
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 28/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import "StarRatingViewController.h"
#import "SWRevealViewController.h"

@interface StarRatingViewController ()

@end

@implementation StarRatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"in Star rating view controller");
    ratingNames = @[@"Bad", @"Average", @"Good", @"Very Good", @"Excellent"];
    starButtons = @[_starOne, _starTwo, _starThree, _starFour, _starFive];
    //[self.navigationItem setHidesBackButton:YES];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

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

- (IBAction)starRating:(id)sender {
    //NSString *rating = [ratingNames objectAtIndex:[sender tag]];
    int rating = [sender tag];
    _ratingName.text = [ratingNames objectAtIndex:([sender tag] - 1)];
    NSLog(@"Rating is %@", [ratingNames objectAtIndex:([sender tag] - 1)]);
    [self set_stars:rating];
}


- (void)set_stars:(int)num {
    
    //rating_name.text = [NSString stringWithFormat:@"%@", desc];
    NSLog(@"In set_stars ");
    for (int loop = 0; loop < 5; loop++) {
        
        if ((loop + 1) <= num) {
            [((UIButton*)starButtons[loop]) setImage:[UIImage imageNamed:@"star_highlighted.png"] forState:UIControlStateNormal];
        }
        else {
            NSLog(@"buttn value is %d", loop);
            [((UIButton*)starButtons[loop]) setImage:[UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
        }
    }
    
   // rating = num;
}
- (IBAction)reviewSubmit:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
