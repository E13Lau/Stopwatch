//
//  ViewController.m
//  miaobiao
//
//  Created by command.Zi on 14/11/13.
//  Copyright (c) 2014年 command.Zi. All rights reserved.
//

#import "ViewController.h"
#import "MZTimerLabel.h"
#import "XYZTableViewCell.h"

@interface ViewController () {
    int numbers;
    BOOL startBtnbool;  //显示为启动时为YES
    BOOL stopBtnbool;   //显示为复位时为YES
}
@end

@implementation ViewController
@synthesize timeTableview = _timeTableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    startBtnbool = YES;
    stopBtnbool = YES;
    secondtime = [[MZTimerLabel alloc]initWithLabel:_secondtimeLabel andTimerType:MZTimerLabelTypeStopWatch];
    firsttime = [[MZTimerLabel alloc]initWithLabel:_firsttimeLabel andTimerType:MZTimerLabelTypeStopWatch];
    secondtime.timeFormat = @"mm:ss.SS";
    firsttime.timeFormat = @"mm:ss.SS";

    self.timelist = [[NSMutableArray alloc]init];
    
    self.timeTableview.delegate = self;
    self.timeTableview.dataSource = self;

    numbers = 0;
    
    [self.timeTableview registerNib:[UINib nibWithNibName:@"XYZTableViewCell" bundle:nil] forCellReuseIdentifier:@"timecell"];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
    //如果在counting，则stop。
    if([firsttime counting]){
        NSDate *stopDate = [NSDate date];
        [firsttime pauseWithDate:stopDate];
        [secondtime pauseWithDate:stopDate];
        [_startbtn setImage:[UIImage imageNamed:@"qidong"] forState:UIControlStateNormal];
        [_stopbtn setImage:[UIImage imageNamed:@"fuwei"] forState:UIControlStateNormal];
        startBtnbool = YES;
        stopBtnbool = YES;
    }else{
        NSDate *startDate = [NSDate date];
        [firsttime startWithDate:startDate];
        [secondtime startWithDate:startDate];
        [_startbtn setImage:[UIImage imageNamed:@"tingzhi"] forState:UIControlStateNormal];
        [_stopbtn setImage:[UIImage imageNamed:@"jici"] forState:UIControlStateNormal];
        [self.timeTableview reloadData];
        startBtnbool = NO;
        stopBtnbool = NO;
    }
}

- (IBAction)stop:(id)sender {
    //如果右边按钮不是复位
    if (stopBtnbool == NO) {
        NSLog(@"%@",secondtime.timeLabel.text);
        NSLog(@"%@",firsttime.timeLabel.text);
        numbers++;
        NSLog(@"%@",self.timelist);
        self.timelistArray  = [[NSMutableArray alloc]init];
        NSString * number = [NSString stringWithFormat:@"计次 %d",numbers];
        NSString * timeString = [NSString stringWithFormat:@"%@",secondtime.timeLabel.text];
        [self.timelistArray addObject:number];
        [self.timelistArray addObject:timeString];
        [self.timelist addObject:self.timelistArray];
        NSLog(@"%@",self.timelist);
        [_timeTableview reloadData];
    }
    [secondtime reset];
    //如果上行数字为暂停状态
    if(![secondtime counting]){
        [_stopbtn setImage:[UIImage imageNamed:@"fuwei"] forState:UIControlStateNormal];
    }
    //如果左边按钮为启动
    if (startBtnbool == YES) {
        [firsttime reset];
        [self.timelist removeAllObjects];
        numbers = 0;
        [_timeTableview reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.timelist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYZTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"timecell" forIndexPath:indexPath];
    //将下标设为数组数量－原下标－1
    NSMutableArray * array = [self.timelist objectAtIndex:[self.timelist count]-indexPath.row-1];
    cell.numberLabel.text = [NSString stringWithFormat:@"%@",array[0]];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@",array[1]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
