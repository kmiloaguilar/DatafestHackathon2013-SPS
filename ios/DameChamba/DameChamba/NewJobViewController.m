//
//  NewJobViewController.m
//  DameChamba
//
//  Created by Camilo Aguilar on 11/2/13.
//  Copyright (c) 2013 Angel Camilo Aguilar Fernandez. All rights reserved.
//

#import "NewJobViewController.h"
#import "UIPlaceHolderTextView.h"
#import "SkillsViewController.h"

@interface NewJobViewController ()
@property (strong, nonatomic) IBOutlet UITextField *txtTitle;
@property (strong, nonatomic) IBOutlet UIPlaceHolderTextView *txtDescription;
@property (strong, nonatomic) IBOutlet UITextField *txtCity;
@property (strong, nonatomic) NSMutableArray *skill;
- (IBAction)btnCancelPressed:(id)sender;
- (IBAction)btnSavePressed:(id)sender;
@property (strong,nonatomic) NSMutableArray *skillsSelected;

@end

@implementation NewJobViewController

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
    
    [self.txtDescription setPlaceholder:@"Description goes here"];
    [self.txtTitle becomeFirstResponder];

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
    SkillsViewController *skillsViewController = (SkillsViewController *)[segue destinationViewController];
    if (!self.skillsSelected) {
        self.skillsSelected = [[NSMutableArray alloc] init];
    }
    skillsViewController.skillsSelected = self.skillsSelected;
}

 



- (IBAction)btnCancelPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)btnSavePressed:(id)sender {
    if ([self fieldsHaveText]) {
        PFObject *job = [PFObject objectWithClassName:@"Jobs"];
        job[@"title"] = self.txtTitle.text;
        job[@"description"] = self.txtDescription.text;
        job[@"city"] = self.txtCity.text;
        job[@"skills"] = self.skillsSelected;
        job[@"createdBy"] = [[PFUser currentUser] username];
        job[@"closed"] = [NSNumber numberWithBool:NO];
        [job saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if (succeeded) {
                [self dismissModalViewControllerAnimated:YES];
            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error userInfo][@"error"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"All fields are required" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (BOOL)fieldsHaveText{
    if (self.txtCity.text.length == 0 || self.txtDescription.text.length == 0 || self.txtTitle.text.length == 0 || self.skillsSelected.count == 0) {
        return NO;
    }
    return YES;
}
@end
