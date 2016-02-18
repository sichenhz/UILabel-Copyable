//
//  UILabel+Copyable.h
//  UILabel+Copyable
//
//  Created by sichenwang on 16/2/18.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Copyable)

/**
 *  是否支持长按复制，默认为NO
 */
@property (nonatomic, assign)IBInspectable BOOL copyingEnabled;

/**
 *  自定义复制的文本，如果该值为nil，则复制默认的text
 */
@property (nonatomic, copy) NSString *copyingText;

@end
