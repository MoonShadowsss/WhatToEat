//
//  WTETableViewController.h
//  WhatToEat
//
//  Created by 翟元浩 on 2018/2/22.
//  Copyright © 2018年 翟元浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTEAddViewController.h"
#import "WTETableViewCell.h"
#import "StoresViewModel.h"
#import "WTEDetailViewController.h"

@interface WTETableViewController : UIViewController

@property (copy, nonatomic) NSString *menuTitle;
@property (strong, nonatomic) StoresViewModel *viewModel;

@end
