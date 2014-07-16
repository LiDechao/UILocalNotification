//
//  AppDelegate.m
//  LocalPush_Test
//
//  Created by mfw on 14-7-16.
//  Copyright (c) 2014年 MFW. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    RootViewController *rvc = [[RootViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:rvc];
    self.window.rootViewController = nc;
    application.applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"接受到本地的通知" message:notification.alertBody delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [view show];
    application.applicationIconBadgeNumber -= 1;
    
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

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    application.applicationIconBadgeNumber=0;
    int count =[[[UIApplication sharedApplication] scheduledLocalNotifications] count];
    if(count>0)
    {
        NSMutableArray *newarry= [NSMutableArray arrayWithCapacity:0];
        for (int i=0; i<count; i++)
        {
            UILocalNotification *notif=[[[UIApplication sharedApplication] scheduledLocalNotifications] objectAtIndex:i];
            notif.applicationIconBadgeNumber=i+1;
            [newarry addObject:notif];
        }
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        if (newarry.count>0)
        {
            for (int i=0; i<newarry.count; i++)
            {
                UILocalNotification *notif = [newarry objectAtIndex:i];
                [[UIApplication sharedApplication] scheduleLocalNotification:notif];
            }
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
