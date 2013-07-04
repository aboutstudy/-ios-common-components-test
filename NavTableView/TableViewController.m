//
//  TableViewController.m
//  NavTableView
//
//  Created by clear on 13-6-25.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"
#import "DetailViewController.h"
#import "RssMainController.h"

@interface TableViewController ()

@end

@implementation TableViewController

@synthesize arrData;

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
    
    NSMutableArray* tmpData = [[NSMutableArray alloc] init];
    [tmpData addObject:@"PHP"];
    [tmpData addObject:@"HTML4"];
    [tmpData addObject:@"iOS"];
    
    self.arrData = tmpData;
    
    self.title = @"Web Dev Top10";
    
    //RSS入口
    UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithTitle:@"RSS" style:UIBarButtonSystemItemOrganize target:self action:@selector(entryRSS)];
    self.navigationItem.rightBarButtonItem = button;
    
    //TableView操作增删操作
    UIBarButtonItem* addMore = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonSystemItemAdd target:self action:@selector(addMore)];
    UIBarButtonItem* delItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(delItem)];
    
    NSArray* leftButtons = [NSArray arrayWithObjects:addMore, delItem, nil];
    self.navigationItem.leftBarButtonItems = leftButtons;
    //self.navigationItem.leftBarButtonItem = addMore;
    
    //NavgationController setting
    //self.navigationController.title = @"Web Dev Top10";
    
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
    return [self.arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }    
    
    // Configure the cell...
    cell.textLabel.text = [self.arrData objectAtIndex:indexPath.row];
    
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
    //UIAlertView* alertViewC = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Test" delegate:nil cancelButtonTitle:@"Yes" otherButtonTitles:@"Other", nil];
    //[alertViewC show];
    
    DetailViewController* detailViewC = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detailViewC.message = [arrData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewC animated:YES];
}

- (void) showHelp
{
    UIAlertView* alertViewC = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Test" delegate:nil cancelButtonTitle:@"Yes" otherButtonTitles:@"Other", nil];
    [alertViewC show];    
}

- (void) addMore
{
    [self.arrData addObject:@"Java"];
    [self.arrData addObject:@"Python"];
    
    NSArray* insertPath = [NSArray arrayWithObjects:
                           [NSIndexPath indexPathForRow:[arrData count] - 1 inSection:0],
                           [NSIndexPath indexPathForRow:[arrData count] - 2 inSection:0],
                            nil];
    
    UITableView* tableV = (UITableView*)self.view;
    [tableV beginUpdates];
    [tableV insertRowsAtIndexPaths:insertPath withRowAnimation: UITableViewRowAnimationFade];
    [tableV endUpdates];
}

- (void) delItem
{    
    UITableView* tableV = (UITableView*)self.view;
    
    NSInteger lastRow = [arrData count] - 1;
    NSLog(@"lastRow:%d", lastRow);
    
    if(lastRow >= 0)
    {
        [self.arrData removeObjectAtIndex: lastRow];
    
        [tableV beginUpdates];
        [tableV deleteRowsAtIndexPaths:[NSArray arrayWithObjects: [NSIndexPath indexPathForRow: lastRow inSection:0], nil] withRowAnimation: UITableViewRowAnimationFade];
        [tableV endUpdates];

    }
    else {
        UIAlertView* alertV = [[UIAlertView alloc] initWithTitle:@"提示" message: @"不能再删除更多了" delegate:nil cancelButtonTitle: @"NO" otherButtonTitles:@"No", nil];
        [alertV show];
    }
}

- (void)entryRSS
{
    RssMainController* rssMain = [[RssMainController alloc] initWithNibName:@"RssMainController" bundle:nil];
    [self.navigationController pushViewController:rssMain animated:YES];
}
@end
