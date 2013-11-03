//
//  LoginViewController.m
//  DameChamba
//
//  Created by Camilo Aguilar on 11/2/13.
//  Copyright (c) 2013 Angel Camilo Aguilar Fernandez. All rights reserved.
//

#import "LoginViewController.h"
#import "TwilioHelper.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)btnLoginPressed:(id)sender;
- (IBAction)btnForgotPasswordPressed:(id)sender;

@end

@implementation LoginViewController

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
    if (currentUser) {
        UITabBarController *main = [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
        [self presentModalViewController:main animated:YES];
    }

    [self.txtEmail becomeFirstResponder];
    
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

- (IBAction)btnLoginPressed:(id)sender {
//    self.btnLogin.hidden = YES;
//    [self.activityIndicator startAnimating];
    if (self.txtEmail.text.length == 0 || self.txtPassword.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Required fields" message:@"Email & Password Required" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        [PFUser logInWithUsernameInBackground:self.txtEmail.text
                                     password:self.txtPassword.text
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                UITabBarController *main = [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
                                                [self presentModalViewController:main animated:YES];
                                            } else {
                                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login Problem" message:@"Check your username and password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                                [alertView show];
                                                
                                            }
                                        }];
    }
//    self.btnLogin.hidden = NO;
//    [self.activityIndicator stopAnimating];
}

- (IBAction)btnForgotPasswordPressed:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Recover Password" message:@"Enter your email:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Recover", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeEmailAddress];
    [alertView show];
}




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UITextField *email = [alertView textFieldAtIndex:0];
        [PFUser requestPasswordResetForEmailInBackground:email.text
                                                   block:^(BOOL succeded, NSError *error){
                                                       if (!error) {
                                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You will receive a email with instructions." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                                           [alertView show];
                                                       }
                                                       else{
                                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error userInfo][@"error"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                                           [alertView show];
                                                       }
                                                   }];
        
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    NSString *inputText = [[alertView textFieldAtIndex:0] text];
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([emailTest evaluateWithObject:inputText] == NO) {
        return NO;
    }
    else{
        return YES;
    }
}
- (IBAction)txtEmailEditingDidBegin:(UITextField *)sender {
    [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}
@end
