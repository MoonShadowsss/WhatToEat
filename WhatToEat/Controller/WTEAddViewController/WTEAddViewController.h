//
//  WTEAddViewController.h
//  WhatToEat
//
//  Created by 翟元浩 on 2018/2/28.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTETableViewController.h"
#import "WTEUserModel.h"

@interface WTEAddViewController : UIViewController

@property (strong, nonatomic) WTEUserModel *userModel;
@property (copy, nonatomic) NSString *menuId;

@end