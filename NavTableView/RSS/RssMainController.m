//
//  RssMainController.m
//  NavTableView
//
//  Created by clear on 13-6-27.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "RssMainController.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

@interface RssMainController ()

@end

@implementation RssMainController
@synthesize arrRSS;
@synthesize arrTest;
@synthesize currPage;

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
    self.currPage = 1;
    
    //加载数据
    NSURL* url = [NSURL URLWithString:@"http://42.121.32.4/test/list.php"];
    __block ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    
    [request setCompletionBlock:^{
        NSString* response = [request responseString];
        //NSLog(@"result:%@", response);
        
        //解析JSON数据
        NSArray* arrData = [response objectFromJSONString];
        
        //NSLog(@"Result:%@", arrData);
        //NSLog(@"Message:%@", [arrData valueForKey:@"message"]);
        
        int count = [[arrData valueForKey:@"count"] intValue];
        
        NSMutableArray* tempRSS = [[NSMutableArray alloc] init];
        NSMutableArray* arrInsertPaths = [[NSMutableArray alloc] init];
        for (int i=0; i < count; i++) {
            NSString* title = [[[arrData valueForKey:@"data"] objectAtIndex:i] valueForKey:@"title"];
            
            [tempRSS addObject: title];
        
            [arrInsertPaths addObject: [NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        self.arrRSS = tempRSS;
        //NSLog(@"arrRSS:%@", self.arrRSS);
        
        UITableView* myTableView = (UITableView*) self.view;
        //[myTableView beginUpdates];
        [myTableView insertRowsAtIndexPaths: arrInsertPaths withRowAnimation:UITableViewRowAnimationFade];
        //[myTableView endUpdates];
        [myTableView reloadData];
        
        //NSString* title = [[arrData objectAtIndex:0] objectForKey:@"title"];
        //NSLog(@"title:%@", title);
        
    }];
    
    [request setFailedBlock:^{
        NSLog(@"failed to get content."); 
    }];
    
    [request startAsynchronous];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return [self.arrRSS count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if(indexPath.row == [arrRSS count]){
        cell.textLabel.text = @"加载更多。。。";
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        
        NSLog(@"更多...");      
        
        
    }
    else {
        cell.textLabel.text = [self.arrRSS objectAtIndex:indexPath.row];
        
        NSLog(@"End of cell buding.");    
        //NSLog(@"arrRSS:%@", self.arrRSS);
    }
    return cell;
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    if(indexPath.row == [arrRSS count]){
        //[self.navigationController popViewControllerAnimated:YES];
        self.currPage++;
        [self getRSSList:self.currPage];
    }    
}

- (void) getRSSList:(NSInteger) page
{    
    //加载数据
    NSString* strURL = [[NSString alloc] initWithFormat:@"http://42.121.32.4/test/list.php?page=%d", page];
    NSURL* url = [NSURL URLWithString:strURL];
    NSLog(@"strURL=%@", strURL);
    
    __block ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    
    [request setCompletionBlock:^{
        NSString* response = [request responseString];
        //NSLog(@"result:%@", response);
        
        //解析JSON数据
        NSArray* arrData = [response objectFromJSONString];
        
        //NSLog(@"Result:%@", arrData);
        //NSLog(@"Message:%@", [arrData valueForKey:@"message"]);
        
        int count = [[arrData valueForKey:@"count"] intValue];
        
        NSMutableArray* tempRSS = [[NSMutableArray alloc] init];
        NSMutableArray* arrInsertPaths = [[NSMutableArray alloc] init];
        for (int i=0; i < count; i++) {
            NSString* title = [[[arrData valueForKey:@"data"] objectAtIndex:i] valueForKey:@"title"];
            
            [tempRSS addObject: title];
            
            [arrInsertPaths addObject: [NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        //self.arrRSS = tempRSS;
        [self.arrRSS addObjectsFromArray:tempRSS];
        NSLog(@"moreRSS:%@", tempRSS);
        //NSLog(@"arrRSS:%@", self.arrRSS);
        
        UITableView* myTableView = (UITableView*) self.view;
        [myTableView beginUpdates];
        [myTableView insertRowsAtIndexPaths: arrInsertPaths withRowAnimation:UITableViewRowAnimationFade];
        [myTableView endUpdates];
    }];
    
    [request setFailedBlock:^{
        NSLog(@"failed to get content."); 
    }];
    
    [request startAsynchronous];    
}

@end
