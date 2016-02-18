//
//  UILabel+Copyable.h
//  UILabel+Copyable
//
//  Created by sichenwang on 16/2/18.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Copyable)

@property (nonatomic, assign)IBInspectable BOOL copyingEnabled;

@property (nonatomic, copy) NSString *copyingText;

@end
