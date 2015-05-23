//
//  ViewController.h
//  miaobiao
//
//  Created by command.Zi on 14/11/13.
//  Copyright (c) 2014年 command.Zi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"

@interface ViewController : UIViewController <MZTimerLabelDelegate,UITableViewDataSource,UITableViewDelegate>
{
    MZTimerLabel * secondtime;
    MZTimerLabel * firsttime;
 //   NSMutableArray * timelist;
}


- (IBAction)stop:(id)sender;
- (IBAction)start:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *secondtimeLabel;
@property (strong, nonatomic) IBOutlet UIButton *startbtn;
@property (strong, nonatomic) IBOutlet UIButton *stopbtn;
@property (strong, nonatomic) IBOutlet UILabel *firsttimeLabel;
@property (strong, nonatomic) IBOutlet UITableView *timeTableview;
@property (strong, nonatomic) NSMutableArray * timelist;
@property (strong, nonatomic) NSMutableArray * timelistArray; //临时数组


@end

