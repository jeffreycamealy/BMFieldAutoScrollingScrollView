//
//  FieldsVC.m
//  FieldAutoScrollingScrollView
//
//  Created by Jeffrey Camealy on 7/17/13.
//  Copyright (c) 2013 bearMountain. All rights reserved.
//

#import "FieldsVC.h"
#import "BMFieldAutoScrollingScrollView.h"

@interface FieldsVC () {
    BMFieldAutoScrollingScrollView *scrollView;
}
@end


@implementation FieldsVC

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}


#pragma mark - Private API

- (void)layoutViews {
    scrollView = [BMFieldAutoScrollingScrollView.alloc initWithFrame:CGRectMake(0, 0, 320, 460)];
    scrollView.contentSize = CGSizeMake(320, 700);
    scrollView.backgroundColor = UIColor.grayColor;
    [self.view addSubview:scrollView];
    
    NSMutableArray *textFields = NSMutableArray.new;
    for (int i =0; i < 12; i++) {
        UITextField *t1 = [UITextField.alloc initWithFrame:CGRectMake(10, 60*i, 300, 40)];
        t1.backgroundColor = UIColor.blueColor;
        [scrollView.bm_contentView addSubview:t1];
        [textFields addObject:t1];
    }
    
    scrollView.textFields = textFields;
}

@end
