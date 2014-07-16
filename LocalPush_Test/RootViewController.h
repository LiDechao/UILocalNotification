//
//  RootViewController.h
//  LocalPush_Test
//
//  Created by mfw on 14-7-16.
//  Copyright (c) 2014年 MFW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    
}


@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIPickerView *pickerView;

@end
