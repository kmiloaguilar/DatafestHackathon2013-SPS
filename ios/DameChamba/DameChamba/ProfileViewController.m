//
//  ProfileViewController.m
//  DameChamba
//
//  Created by Camilo Aguilar on 11/2/13.
//  Copyright (c) 2013 Angel Camilo Aguilar Fernandez. All rights reserved.
//

#import "ProfileViewController.h"
#import "SkillsViewController.h"
#import "JobsViewController.h"

@interface ProfileViewController ()
- (IBAction)btnLogoutPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblCity;
@property (strong, nonatomic) IBOutlet UILabel *lblPhone;
@property (strong, nonatomic) NSMutableArray *userSkills;

@end

@implementation ProfileViewController

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
    
    PFUser *currentUser = [PFUser currentUser];
    
    self.lblCity.text = currentUser[@"city"];
    self.lblEmail.text = [currentUser username];
    self.lblName.text = currentUser[@"name"];
    self.lblPhone.text = currentUser[@"phone"];
    self.userSkills = currentUser[@"skills"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    PFUser *currentUser = [PFUser currentUser];
    if (!self.userSkills) {
        self.userSkills = [[NSMutableArray alloc] init];
    }
    currentUser[@"skills"] = self.userSkills;
    [currentUser saveInBackground];
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}

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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"jobscreated"]) {
        JobsViewController *jobsViewController = (JobsViewController *)[segue destinationViewController];
        jobsViewController.filterForJobs = @"jobscreated";
    }
    else if ([[segue identifier] isEqualToString:@"jobsapplied"]){
        JobsViewController *jobsViewController = (JobsViewController *)[segue destinationViewController];
        jobsViewController.filterForJobs = @"jobsapplied";
    }
    else if ([[segue identifier] isEqualToString:@"skills"]){
        SkillsViewController *skillsViewController = (SkillsViewController *)[segue destinationViewController];
        if (!self.userSkills) {
            self.userSkills = [[NSMutableArray alloc] init];
        }
        skillsViewController.skillsSelected = self.userSkills;

    }
}

 

- (IBAction)btnLogoutPressed:(id)sender {
    [PFUser logOut];
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    
    [self presentModalViewController:nav animated:YES];
}
@end
