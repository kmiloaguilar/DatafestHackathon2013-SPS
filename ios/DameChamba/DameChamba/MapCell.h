//
//  MapCell.h
//  DameChamba
//
//  Created by Camilo Aguilar on 11/3/13.
//  Copyright (c) 2013 Angel Camilo Aguilar Fernandez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapCell : UITableViewCell

@property (strong,nonatomic) IBOutlet MKMapView *mapView;

@end
