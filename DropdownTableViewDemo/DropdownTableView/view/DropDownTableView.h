//
//  DropDownTableView.h
//  DropdownTableView
//
//  Created by Uncle.Chen on 11/19/15.
//  Copyright © 2015 uncle.chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownTableView : UITableView

@property (nonatomic, strong) NSArray *mainArray;/**< 输入数据 */
@property (nonatomic, strong) NSMutableArray *selectArray;/**< 已选择数组 */

/*
 * parameters
 * selectArray  选中数据
 * allArray     全部数据
 */
typedef void (^ConfirmBlock)(NSArray *selectArray, NSArray *allArray);
@property (nonatomic, copy) ConfirmBlock confirmBlock;

@end
