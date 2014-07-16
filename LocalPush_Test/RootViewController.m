//
//  RootViewController.m
//  LocalPush_Test
//
//  Created by mfw on 14-7-16.
//  Copyright (c) 2014年 MFW. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize pickerView;
@synthesize dataArray;

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
    dataArray = [NSArray arrayWithObjects:@"海贼",@"火影",@"死神", nil];
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.view addSubview:pickerView];
    
    //增加本地推送
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:10];
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    if (noti) {
        //设置时间
        noti.fireDate = date;
        //设置时区
        noti.timeZone = [NSTimeZone defaultTimeZone];
        //设置重复间隔
        noti.repeatInterval = NSWeekdayCalendarUnit;
        //推送声音
        noti.soundName = UILocalNotificationDefaultSoundName;//添加声音片段，如@"beijing.caf"
        //内容
        noti.alertBody = @"推送内容";
        //现实在icon上的红色圈中的数字
        noti.applicationIconBadgeNumber = [[[UIApplication sharedApplication] scheduledLocalNotifications] count ] + 1;
        //添加userInfo，方便撤销时使用
        NSDictionary *infoDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"name",@"key", nil];
        noti.userInfo = infoDic;
        //添加推送到UIapplication
        [[UIApplication sharedApplication] scheduleLocalNotification:noti];
    }
    
    
    
    //3、取消一个本地推送
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArr = [app scheduledLocalNotifications];
    
    //声明本地通知对象
    UILocalNotification *localNoti;
    
    if (localArr) {
        for (UILocalNotification *noti in localArr) {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                NSString *inKey = [dict objectForKey:@"key"];
                if ([inKey isEqualToString:@"key"]) {
                    if (localNoti){
                        localNoti = nil;
                    }
                    break;
                }
            }
        }
        
        //判断是否找到已经存在的相同key的推送
        if (!localNoti) {
            //不存在 初始化
            localNoti = [[UILocalNotification alloc] init];
        }
        
        if (localNoti) {
            //不推送 取消推送
            [app cancelLocalNotification:localNoti];
            return;
        }
    }
    
}

- (void)cancelAnti
{
    //3、取消一个本地推送
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArr = [app scheduledLocalNotifications];
    
    //声明本地通知对象
    UILocalNotification *localNoti;
    
    if (localArr) {
        for (UILocalNotification *noti in localArr) {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                NSString *inKey = [dict objectForKey:@"key"];
                if ([inKey isEqualToString:@"key"]) {
                    if (localNoti){
                        localNoti = nil;
                    }
                    break;
                }
            }
        }
        
        //判断是否找到已经存在的相同key的推送
        if (!localNoti) {
            //不存在 初始化
            localNoti = [[UILocalNotification alloc] init];
        }
        
        if (localNoti) {
            //不推送 取消推送
            [app cancelLocalNotification:localNoti];
            return;
        }
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [dataArray objectAtIndex:row];
}

//xua
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%@",[dataArray objectAtIndex:row]);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
