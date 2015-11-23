//
//  DropdownTableViewDemo.m
//  DropdownTableViewDemo
//
//  Created by Uncle.Chen on 11/22/15.
//  Copyright © 2015 uncle.chen. All rights reserved.
//

#import "DropdownTableViewDemo.h"
#import "DropDownTableView.h"
#import "DropDownTableViewViewModel.h"
#import "DropDownTableViewDemoData.h"

#define DEFBLUECOLOR [UIColor colorWithRed:0 green:0.59 blue:1 alpha:1]
#define DEFYELLOWCOLOR [UIColor colorWithRed:0.89 green:0.56 blue:0 alpha:1]
#define DEFGREENCOLOR [UIColor colorWithRed:0.4 green:0.78 blue:0.33 alpha:1]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface DropdownTableViewDemo ()

@property (nonatomic, strong) DropDownTableView *dropDownTableView;

@end

@implementation DropdownTableViewDemo

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadBasicView];
        [self addSubview:self.dropDownTableView];
    }
    return self;
}

- (DropDownTableView *)dropDownTableView {
    if (!_dropDownTableView) {
        _dropDownTableView = [[DropDownTableView alloc] initWithFrame:({
            CGRectMake(0, 44.f,
                       CGRectGetWidth(self.frame),
                       CGRectGetHeight(self.frame));
        })];
        _dropDownTableView.mainArray = [DropDownTableViewDemoData createData];
        WS(weakSelf);
        _dropDownTableView.confirmBlock = ^(NSArray *selectArray, NSArray *allArray) {
            weakSelf.confirmBlock(selectArray, allArray);
        };
    }
    return _dropDownTableView;
}


- (void)loadBasicView {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    UIView *topView = [[UIView alloc] initWithFrame:({
        CGRectMake(0, 0, CGRectGetWidth(self.frame), 44.f);
    })];
    topView.backgroundColor = [UIColor blueColor];
    [self addSubview:topView];
    
    NSArray *textArray = @[@"取消", @"全选", @"确定"];
    NSArray *backColorArray = @[DEFYELLOWCOLOR, DEFBLUECOLOR, DEFGREENCOLOR];
    NSInteger index = 0;
    for (NSString *text in textArray) {
        UIButton *button = [[UIButton alloc] initWithFrame:({
            CGRectMake(CGRectGetWidth(topView.frame)/3*index,
                       0.f,
                       CGRectGetWidth(topView.frame)/3,
                       CGRectGetHeight(topView.frame));
        })];
        button.tag = index;
        button.backgroundColor = backColorArray[index];
        [button setTitle:text forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
        [topView addSubview:button];
        index++;
    }
}

#pragma mark - button method

- (void)buttonAction:(UIButton *)sender {
    switch (sender.tag) {
        case DropDownTableViewButtonCancle:
            [self removeFromSuperview];
            break;
        case DropDownTableViewButtonSelectAll: {
            UIButton *button = [self viewWithTag:DropDownTableViewButtonSelectAll];
            
            if ([button.titleLabel.text isEqualToString:@"全选"]) {
                [button setTitle:@"取消全选" forState:UIControlStateNormal];
                
                self.dropDownTableView.selectArray = [DropDownTableViewViewModel selectAllWithMainArray:({
                    self.dropDownTableView.mainArray;
                })];
                [self.dropDownTableView reloadData];
            } else {
                [button setTitle:@"全选" forState:UIControlStateNormal];
                
                [DropDownTableViewViewModel deselectAllWithMainArray:self.dropDownTableView.mainArray];
                [self.dropDownTableView.selectArray removeAllObjects];
                [self.dropDownTableView reloadData];
            }
        }
            break;
        case DropDownTableViewButtonConfirm: {
            if (self.confirmBlock) {
                self.confirmBlock(self.dropDownTableView.selectArray,
                                  self.dropDownTableView.mainArray);
            }
            [self removeFromSuperview];
        }
            break;
            
        default:
            break;
    }
}

@end
