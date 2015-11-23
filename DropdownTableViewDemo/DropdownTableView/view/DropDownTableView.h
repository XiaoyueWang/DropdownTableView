//
//  DropDownTableView.h
//  DropdownTableView
//
//  Created by Uncle.Chen on 11/19/15.
//  Copyright © 2015 uncle.chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DropDownTableViewButton) {
    DropDownTableViewButtonCancle,
    DropDownTableViewButtonSelectAll,
    DropDownTableViewButtonConfirm,
};

@interface DropDownTableView : UITableView

@property (nonatomic, strong) NSArray *mainArray;/**< 输入数据 */
@property (nonatomic, strong) NSMutableArray *selectArray;/**< 已选择数组 */

typedef void (^ConfirmBlock)(NSArray *selectArray, NSArray *allArray);
@property (nonatomic, copy) ConfirmBlock confirmBlock;

@end
