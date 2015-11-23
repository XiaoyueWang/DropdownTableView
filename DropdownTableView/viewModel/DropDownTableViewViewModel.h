//
//  DropDownTableViewViewModel.h
//  DropdownTableView
//
//  Created by Uncle.Chen on 11/19/15.
//  Copyright © 2015 uncle.chen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DropDownTableViewViewModelLevel) {
    DropDownTableViewViewModelLevelOne,
    DropDownTableViewViewModelLevelTwo,
    DropDownTableViewViewModelLevelThree,
};

typedef NS_ENUM(NSInteger, DropDownTableViewViewModelState) {
    DropDownTableViewViewModelStateOpen = -1,
    DropDownTableViewViewModelStateClosed = 1,
};

@interface DropDownTableViewViewModel : NSObject

@property (nonatomic, assign) NSInteger level;/**< 级别 */
@property (nonatomic, assign) NSInteger state;/**< 状态 */
@property (nonatomic, strong) NSString *ID;/**< 员工ID */
@property (nonatomic, strong) NSString *name;/**< 员工姓名 */
@property (nonatomic, strong) NSString *deptId;/**< 部门ID */
@property (nonatomic, strong) NSString *deptName;/**< 部门名称 */
@property (nonatomic, strong) NSString *cityId;/**< 地市ID */
@property (nonatomic, strong) NSString *cityName;/**< 地市名称 */
@property (nonatomic, strong) NSString *parentId;/**< 父节点ID */

+ (NSMutableArray *)reloadCurrentArrayWithMainArray:(NSArray *)mainArray
                                       currentArray:(NSArray *)currentArray
                                          selectRow:(NSInteger)selectRow;
+ (NSMutableArray *)reloadSelectArrayWithCurrentArray:(NSArray *)currentArray;
+ (NSMutableArray *)selectAllWithMainArray:(NSArray *)mainArray;
+ (void)deselectAllWithMainArray:(NSArray *)mainArray;

@end
