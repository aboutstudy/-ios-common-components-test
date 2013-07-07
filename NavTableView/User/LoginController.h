//
//  LoginController.h
//  NavTableView
//
//  Created by clear on 13-7-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController
{
    BOOL* isValidUser;
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
}
@property (retain, nonatomic) IBOutlet UIButton *doSubmit;
- (IBAction)doLogin:(id)sender;
- (IBAction)textFieldExitEditing:(id)sender;
@end
