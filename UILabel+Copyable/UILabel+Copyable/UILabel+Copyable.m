//
//  UILabel+Copyable.m
//  UILabel+Copyable
//
//  Created by sichenwang on 16/2/18.
//  Copyright © 2016年 sichenwang. All rights reserved.
//

#import "UILabel+Copyable.h"
#import <objc/runtime.h>

@interface UILabel ()

@property (nonatomic) UILongPressGestureRecognizer *gestureRecognizer;

@end

@implementation UILabel (Copyable)

#pragma mark - Override Methods

- (BOOL)canBecomeFirstResponder {
    return self.copyingEnabled;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copy:) && self.copyingEnabled);
}

#pragma mark - Private Methods

- (void)setupGestureRecognizer {
    // Remove gesture recognizer
    if (self.gestureRecognizer) {
        [self removeGestureRecognizer:self.gestureRecognizer];
        self.gestureRecognizer = nil;
    }
    
    if (self.copyingEnabled) {
        self.userInteractionEnabled = YES;
        // Enable gesture recognizer
        self.gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognized:)];
        [self addGestureRecognizer:self.gestureRecognizer];
    }
}

- (void)gestureRecognized:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.gestureRecognizer) {
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            [self becomeFirstResponder];
            UIMenuController *menuController = [UIMenuController sharedMenuController];
            [menuController setTargetRect:self.bounds inView:self];
            menuController.arrowDirection = UIMenuControllerArrowDefault;
            [menuController setMenuVisible:YES animated:YES];
        }
    }
}

- (void)copy:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.copyingText ? : self.text];
}

#pragma mark - Getter/Setter

- (BOOL)copyingEnabled {
    return [objc_getAssociatedObject(self, @selector(copyingEnabled)) boolValue];
}

- (void)setCopyingEnabled:(BOOL)copyingEnabled {
    if (self.copyingEnabled != copyingEnabled) {
        objc_setAssociatedObject(self, @selector(copyingEnabled), @(copyingEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self setupGestureRecognizer];
    }
}

- (UILongPressGestureRecognizer *)gestureRecognizer {
    return objc_getAssociatedObject(self, @selector(gestureRecognizer));
}

- (void)setGestureRecognizer:(UILongPressGestureRecognizer *)gestureRecognizer {
    objc_setAssociatedObject(self, @selector(gestureRecognizer), gestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)copyingText {
    return objc_getAssociatedObject(self, @selector(copyingText));
}

- (void)setCopyingText:(NSString *)copyingText {
    objc_setAssociatedObject(self, @selector(copyingText), copyingText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
