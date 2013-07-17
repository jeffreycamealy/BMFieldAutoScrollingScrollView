//
//  BMFieldAutoScrollingScrollView.h
//  FieldAutoScrollingScrollView
//
//  Created by Jeffrey Camealy on 7/17/13.
//  Copyright (c) 2013 bearMountain. All rights reserved.
//


// Protrait Only

#import <UIKit/UIKit.h>

@protocol BMFieldAutoScrollingScrollViewDelegate <NSObject>

- (void)textFieldDidReturn:(UITextField *)textField;
- (void)finalTextFieldDidReturn;

@end

@interface BMFieldAutoScrollingScrollView : UIScrollView

@property (weak) id<BMFieldAutoScrollingScrollViewDelegate> autoScrollingDelegate;
@property UIView *bm_contentView;
@property (nonatomic) NSArray *textFields;

@end
