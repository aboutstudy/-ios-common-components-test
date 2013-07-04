//
//  RssMainController.h
//  NavTableView
//
//  Created by clear on 13-6-27.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RssMainController : UITableViewController

@property (retain, nonatomic) NSMutableArray* arrRSS;
@property (retain, nonatomic) NSMutableArray* arrTest;
@property (assign, nonatomic) int currPage;

@end
