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
{
    BOOL enlargedForEditing;
    float prevContentOffsetY;
}
@end


@implementation BMFieldAutoScrollingScrollView

#pragma mark - Init Method

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.showsVerticalScrollIndicator = NO;
        [self setupBMContentView];
        [self setupScrollViewDelegate];
    }
    return self;
}


#pragma mark - Private API

- (void)setupBMContentView {
    _bm_contentView = UIView.new;
    [self addSubview:_bm_contentView];
}

- (void)setupScrollViewDelegate {
    self.delegate = self;
}

- (void)scrollToField:(UITextField *)field {
    float targetTextFieldBottomY = self.frame.size.height-KeyboardHeight-SpacerOffset;
    CGRect normalizedFrame = [field convertRect:field.bounds toView:self.bm_contentView];
    float contentOffsetY = CGRectGetMaxY(normalizedFrame) - targetTextFieldBottomY;
    if (contentOffsetY < self.contentOffset.y) return;

    [self setContentOffset:CGPointMake(0, contentOffsetY) animated:YES];
    prevContentOffsetY = contentOffsetY;
}


#pragma mark - Custom Setter

- (void)setContentSize:(CGSize)contentSize {
    [super setContentSize:contentSize];
    self.bm_contentView.frame = CGRectMake(0, 0, contentSize.width, contentSize.height);
}

- (void)setTextFields:(NSArray *)textFields {
    _textFields = textFields;
    
    for (UITextField *textField in textFields) {
        textField.delegate = self;
    }
}


#pragma mark - UITextField Delegate Method

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSUInteger index = [self.textFields indexOfObject:textField];
    if (index == self.textFields.count-1) {
        if ([self.autoScrollingDelegate respondsToSelector:@selector(finalTextFieldDidReturn)]) {
            [self.autoScrollingDelegate finalTextFieldDidReturn];
        }
    } else {
        [self.textFields[index+1] becomeFirstResponder];
    }
    
    if ([self.autoScrollingDelegate respondsToSelector:@selector(textFieldDidReturn:)]) {
        [self.autoScrollingDelegate textFieldDidReturn:textField];
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (!enlargedForEditing) {
        super.contentSize = CGSizeMake(self.contentSize.width, self.contentSize.height+KeyboardHeight);
        enlargedForEditing = YES;
    }
    [self scrollToField:textField];
}


#pragma mark - Scrollview Delegate Method

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self endEditing:YES];
    
    if (enlargedForEditing) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.contentSize = CGSizeMake(self.contentSize.width, self.contentSize.height-KeyboardHeight);
                         }];
        enlargedForEditing = NO;
    }
}

@end
