//
//  LoginController.m
//  NavTableView
//
//  Created by clear on 13-7-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "LoginController.h"
#import "TableViewController.h"
#import "JSONKit.h"
#import "ASIHTTPRequest.h"

@interface LoginController ()

@end

@implementation LoginController
@synthesize doSubmit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setDoSubmit:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [doSubmit release];
    [super dealloc];
}

- (IBAction)doLogin:(id)sender {
    NSURL* loginApi = [NSURL URLWithString:@"http://readlist/api/login.json?username=test&password=123456"];
    ASIHTTPRequest* _request = [ASIHTTPRequest requestWithURL:loginApi];
    [_request setDelegate:self];
    [_request startAsynchronous];
}

- (void) requestFinished:(ASIHTTPRequest*)request
{
    NSString* strResponse = [request responseString];
    NSArray* arrResponse= [strResponse objectFromJSONString];
    
    NSLog(@"login api return:%@", strResponse);
    
    NSNumber* status = [arrResponse valueForKey:@"status"];
    NSLog(@"status:%@", status);
          
    if ([status isEqualToNumber:[NSNumber numberWithInt:200]]) {
        TableViewController* rootViewC = [[TableViewController alloc] init];
        [self.navigationController pushViewController:rootViewC animated:YES];        
    }
    else {
        
        UIAlertView* showStatus = [[UIAlertView alloc] initWithTitle:@"接口返回" message:@"登陆失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancle", nil];
        [showStatus show];
    }
}

- (void)requestFailed:(ASIHTTPRequest*)request
{
    NSError* error = [request error];
}

@end
