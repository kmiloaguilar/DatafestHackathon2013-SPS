//
//  JobCell.h
//  DameChamba
//
//  Created by Camilo Aguilar on 11/2/13.
//  Copyright (c) 2013 Angel Camilo Aguilar Fernandez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *lblTitle;
@property (strong,nonatomic) IBOutlet UILabel *lblSkills;
@property (strong,nonatomic) IBOutlet UILabel *lblDate;
@property (strong,nonatomic) IBOutlet UILabel *lblPlace;

@end
