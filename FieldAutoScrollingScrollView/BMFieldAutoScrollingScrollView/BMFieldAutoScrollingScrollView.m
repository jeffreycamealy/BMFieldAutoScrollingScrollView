//
//  BMFieldAutoScrollingScrollView.m
//  FieldAutoScrollingScrollView
//
//  Created by Jeffrey Camealy on 7/17/13.
//  Copyright (c) 2013 bearMountain. All rights reserved.
//

#import "BMFieldAutoScrollingScrollView.h"

#define KeyboardHeight 216
#define SpacerOffset 10

@interface BMFieldAutoScrollingScrollView () <UITextFieldDelegate, UIScrollViewDelegate>

@end


@implementation BMFieldAutoScrollingScrollView

#pragma mark - Init Method

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _bm_contentView = UIView.new;
        [self addSubview:_bm_contentView];
        self.delegate = self;
    }
    return self;
}


#pragma mark - Private API

- (void)scrollToField:(UITextField *)field {
    CGRect rect = CGRectMake(0, field.frame.origin.y+KeyboardHeight,
                             field.frame.size.width, field.frame.size.height);
    [self scrollRectToVisible:rect animated:YES];
//    float targetTextFieldBottomY = self.frame.size.height-KeyboardHeight-SpacerOffset;
//    float contentOffsetY = CGRectGetMaxY(field.frame) - targetTextFieldBottomY;
//    if (contentOffsetY < self.contentOffset.y) return;
//    
//    [self setContentOffset:CGPointMake(0, contentOffsetY) animated:YES];
}


#pragma mark - Custom Setter

- (void)setTextFields:(NSArray *)textFields {
    _textFields = textFields;
    
    for (UITextField *textField in textFields) {
        textField.delegate = self;
    }
}


#pragma mark - UITextField Delegate Method

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSUInteger index = [self.textFields indexOfObject:textField];
    [self.autoScrollingDelegate textFieldDidReturn:textField];
    if (index == self.textFields.count-1) {
        [self.autoScrollingDelegate finalTextFieldDidReturn];
    } else {
        UITextField *nextField = self.textFields[index+1];
        [nextField becomeFirstResponder];
    }
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self scrollToField:textField];
}


#pragma mark - Scrollview Delegate Method

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self endEditing:YES];
}

@end
