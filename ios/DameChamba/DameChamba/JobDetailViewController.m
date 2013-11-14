//
//  JobDetailViewController.m
//  DameChamba
//
//  Created by Camilo Aguilar on 11/2/13.
//  Copyright (c) 2013 Angel Camilo Aguilar Fernandez. All rights reserved.
//

#import "JobDetailViewController.h"
#import "MapCell.h"
#import "JobDetailCell.h"
#import <MapKit/MapKit.h>

@interface JobDetailViewController ()
- (IBAction)btnBackPressed:(id)sender;
- (IBAction)btnApplyPressed:(id)sender;
@property (strong,nonatomic) NSArray *skills;

@end

@implementation JobDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.skills = self.jobDetail[@"skills"];
    
//    PFUser *currentUser = [PFUser currentUser];
//    if ([[currentUser username] isEqualToString:self.jobDetail[@"createdBy"]]) {
//        self.navigationItem.rightBarButtonItem = nil;
//    }
//    else{
//        PFQuery *query = [PFQuery queryWithClassName:@"Applications"];
//        [query whereKey:@"job" equalTo:self.jobDetail];
//        [query whereKey:@"applicationBy" equalTo:[PFUser currentUser]];
//        PFObject *application = [query getFirstObject];
//        if (application == NULL) {
//            self.navigationItem.rightBarButtonItem = nil;
//        }
//    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.skills = nil;
    self.jobDetail = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 1;
    }
    return self.skills.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"jobcell";
    UITableViewCell *cell;
    if (indexPath.row == 0 && indexPath.section == 0) {
        JobDetailCell *jobCell = (JobDetailCell *) [tableView dequeueReusableCellWithIdentifier:@"jobcell"];
        jobCell.lblTitle.text = self.jobDetail[@"title"];
        NSDate *date = self.jobDetail.createdAt;
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateStyle:NSDateFormatterMediumStyle];
        [df setTimeStyle:NSDateFormatterMediumStyle];
        jobCell.lblDate.text = [NSString stringWithFormat:@"Created on %@",[df stringFromDate:date]];
        jobCell.lblDescription.text = self.jobDetail[@"description"];
        return jobCell;
    }
    else if (indexPath.row == 0 && indexPath.section == 1){
        CellIdentifier = @"mapcell";
        MapCell *mapCell = (MapCell *) [tableView dequeueReusableCellWithIdentifier:@"mapcell"];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:self.jobDetail[@"city"]
                     completionHandler:^(NSArray* placemarks, NSError* error){
                         if (placemarks && placemarks.count > 0) {
                             CLPlacemark *topResult = [placemarks objectAtIndex:0];
                             MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                             
                             MKCoordinateRegion region = mapCell.mapView.region;
                             region.center = placemark.region.center;
                             region.span.longitudeDelta /= 8.0;
                             region.span.latitudeDelta /= 8.0;
                             
                             [mapCell.mapView setRegion:region animated:YES];
                             [mapCell.mapView addAnnotation:placemark];
                         }
                     }
         ];
        return mapCell;
    }
    else {
        CellIdentifier = @"skillcell";
        cell = [tableView dequeueReusableCellWithIdentifier:@"skillcell" forIndexPath:indexPath];
        cell.textLabel.text = [self.skills objectAtIndex:indexPath.row];
        return cell;
    }
    
    return cell;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height;
    if (indexPath.row == 0 && indexPath.section == 0) {
        height = 120.0f;
    }
    else if (indexPath.row == 0 && indexPath.section == 1) {
        height = 200.0f;
    }
    else{
        height = 44.0f;
    }
    return height;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Job Information";
    }
    else if (section == 1){
        return @"Location";
    }
    else{
        return @"Skills";
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)btnBackPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)btnApplyPressed:(id)sender {
    PFObject *application = [PFObject objectWithClassName:@"Applications"];
    application[@"user"] = [PFUser currentUser];
    application[@"job"] = self.jobDetail;
    [application saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Great" message:@"You already applied! Wait for contact from employer" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
}
@end
