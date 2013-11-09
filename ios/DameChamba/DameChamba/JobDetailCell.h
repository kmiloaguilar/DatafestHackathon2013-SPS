//
//  JobDetailCell.h
//  DameChamba
//
//  Created by Camilo Aguilar on 11/3/13.
//  Copyright (c) 2013 Angel Camilo Aguilar Fernandez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobDetailCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *lblTitle;
@property (strong,nonatomic) IBOutlet UILabel *lblDate;
@property (strong,nonatomic) IBOutlet UILabel *lblDescription;

@end
