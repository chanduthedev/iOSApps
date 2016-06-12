//
//  CustomCell.h
//  TrafficBuddy
//
//  Created by Chandrasekhar Pasumarthi on 21/04/16.
//  Copyright © 2016 Testing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *incidentDate;

@property (weak, nonatomic) IBOutlet UILabel *reasonForFine;
@end
