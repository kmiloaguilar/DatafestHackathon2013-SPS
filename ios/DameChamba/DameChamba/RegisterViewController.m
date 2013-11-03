//
//  RegisterViewController.m
//  DameChamba
//
//  Created by Camilo Aguilar on 11/2/13.
//  Copyright (c) 2013 Angel Camilo Aguilar Fernandez. All rights reserved.
//

#import "RegisterViewController.h"
#import "TwilioHelper.h"

@interface RegisterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtConfirmPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtCity;
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNumber;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segUserType;
- (IBAction)btnSavePressed:(id)sender;
- (IBAction)btnBackPressed:(id)sender;
- (IBAction)txtCityEditingChanged:(id)sender;

@end

@implementation RegisterViewController

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

    [self.txtName becomeFirstResponder];
    
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)btnSavePressed:(id)sender {
    if ([self fieldsHaveText]) {
        if ([self emailIsValid]) {
            if ([self passwordMatches]) {
                PFUser *user = [PFUser user];
                user.username = self.txtEmail.text;
                user.password = self.txtPassword.text;
                user.email = self.txtEmail.text;
                
                // other fields can be set just like with PFObject
                user[@"phone"] = self.txtPhoneNumber.text;
                user[@"name"] = self.txtName.text;
                user[@"city"] = self.txtCity.text;
                user[@"distanceForJobs"] = [NSNumber numberWithDouble:45.0];
                
                [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Great" message:@"Now you can start using DameChamba" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [alertView show];
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    } else {
                        NSString *errorString = [error userInfo][@"error"];
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                }];
            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Password doesn't match." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
        else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Email address is not valid." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"All fields are required." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (IBAction)btnBackPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)txtCityEditingChanged:(id)sender {
}


- (BOOL)fieldsHaveText{
    if (self.txtName.text.length == 0 || self.txtEmail.text.length == 0 || self.txtPassword.text.length == 0 || self.txtConfirmPassword.text.length == 0 || self.txtCity.text.length == 0 || self.txtPhoneNumber.text.length == 0) {
        return NO;
    }
    return YES;
}

- (BOOL)emailIsValid{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([emailTest evaluateWithObject:self.txtEmail.text] == NO) {
        return NO;
    }
    return YES;
}

- (BOOL)passwordMatches{
    if ([self.txtPassword.text isEqualToString:self.txtConfirmPassword.text]) {
        return YES;
    }
    return NO;
}
@end
