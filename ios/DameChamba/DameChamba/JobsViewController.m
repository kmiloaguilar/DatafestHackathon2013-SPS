//
//  JobsViewController.m
//  DameChamba
//
//  Created by Camilo Aguilar on 11/2/13.
//  Copyright (c) 2013 Angel Camilo Aguilar Fernandez. All rights reserved.
//

#import "JobsViewController.h"
#import "JobCell.h"
#import "JobDetailViewController.h"

@interface JobsViewController ()

@property (strong,nonatomic) NSMutableArray *jobs;

@end

@implementation JobsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)queryRecentJobs{
    PFQuery *query = [PFQuery queryWithClassName:@"Jobs"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"skills" containedIn:[PFUser currentUser][@"skills"]];
    [query whereKey:@"city" equalTo:[PFUser currentUser][@"city"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (objects) {
            self.jobs = [[NSMutableArray alloc] initWithArray:objects];
            [self.tableView reloadData];
        }
    }];
}

- (void)queryJobsCreatedByCurrentUser{
    PFQuery *query = [PFQuery queryWithClassName:@"Jobs"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"createdBy" equalTo:[PFUser currentUser].username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (objects) {
            self.jobs = [[NSMutableArray alloc] initWithArray:objects];
            [self.tableView reloadData];
        }
    }];
}

//- (void)queryJobsThatCurrentUserApplied{
//    PFQuery *query = [PFQuery queryWithClassName:@"Applications"];
//    [query whereKey:@"appliedBy" containsAllObjectsInArray:<#(NSArray *)#>]
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.jobs = [[NSMutableArray alloc] init];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.filterForJobs isEqualToString:@"jobsapplied"]) {
        
    }
    else if ([self.filterForJobs isEqualToString:@"jobscreated"]) {
        
    }
    else{
        [self queryRecentJobs];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.jobs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"jobcell";
    JobCell *cell = (JobCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFObject *job = [self.jobs objectAtIndex:indexPath.row];
    cell.lblTitle.text = job[@"title"];
    cell.lblPlace.text = job[@"city"];
    NSDate *date = job.createdAt;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterMediumStyle];
    [df setTimeStyle:NSDateFormatterMediumStyle];
    cell.lblDate.text = [NSString stringWithFormat:@"Created on %@",[df stringFromDate:date]];
    NSMutableArray *skills = job[@"skills"];
    if (skills.count > 0) {
        cell.lblSkills.text = [NSString stringWithFormat:@"Skills (%i)",skills.count];
    }
    else{
        cell.lblSkills.text = @"";
    }
    cell.tag = indexPath.row;
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject *job = [self.jobs objectAtIndex:indexPath.row];
    PFUser *currentUser = [PFUser currentUser];
    if ([[currentUser username] isEqualToString:job[@"createdBy"]]) {
        return YES;
    }
    
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"jobdetail"]) {
        UITableViewCell *cell = (UITableViewCell *)sender;
        JobDetailViewController *jobDetailViewController = [segue destinationViewController];
        jobDetailViewController.jobDetail = [self.jobs objectAtIndex:cell.tag];
    }
    
}



@end
