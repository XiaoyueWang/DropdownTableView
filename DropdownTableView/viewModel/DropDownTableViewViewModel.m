//
//  DropDownTableViewViewModel.m
//  DropdownTableView
//
//  Created by Uncle.Chen on 11/19/15.
//  Copyright © 2015 uncle.chen. All rights reserved.
//

#import "DropDownTableViewViewModel.h"

@implementation DropDownTableViewViewModel

#pragma mark - model method

+ (NSMutableArray *)reloadCurrentArrayWithMainArray:(NSArray *)mainArray
                                      currentArray:(NSArray *)currentArray
                                         selectRow:(NSInteger)selectRow {
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    DropDownTableViewViewModel *selectViewModel = currentArray[selectRow];
    NSInteger state = selectViewModel.state;;
    
    if (state == DropDownTableViewViewModelStateClosed) {
        for (DropDownTableViewViewModel *viewModel in currentArray) {
            [resultArray addObject:viewModel];
            
            if (viewModel == selectViewModel) {
                viewModel.state = 0-viewModel.state;
                
                if (viewModel.level == DropDownTableViewViewModelLevelOne) {
                    for (DropDownTableViewViewModel *subViewModel in mainArray[1]) {
                        BOOL result = ({
                            [subViewModel.parentId isEqualToString:viewModel.cityId];
                        });
                        if (result) {
                            [resultArray addObject:subViewModel];
                        }
                    }
                } else if (viewModel.level == DropDownTableViewViewModelLevelTwo) {
                    for (DropDownTableViewViewModel *subViewModel in mainArray[2]) {
                        BOOL result = ({
                            [subViewModel.parentId isEqualToString:viewModel.deptId];
                        });
                        if (result) {
                            [resultArray addObject:subViewModel];
                        }
                    }
                }
            }
        }
    } else {
        if (selectViewModel.level == DropDownTableViewViewModelLevelOne) {
            for (DropDownTableViewViewModel *viewModel in currentArray) {
                
                if (viewModel.cityId != selectViewModel.cityId) {
                    [resultArray addObject:viewModel];
                } //添加除选中节点以及其子节点以外的并且已经在当前显示数组中的所有节点
                
                if ([currentArray indexOfObject:viewModel] == selectRow) {
                    [resultArray addObject:viewModel];
                } //添加选中节点
                
                if (viewModel == selectViewModel) {
                    viewModel.state = 0-viewModel.state;
                }
            }
        } else if (selectViewModel.level == DropDownTableViewViewModelLevelTwo) {
            
            for (DropDownTableViewViewModel *viewModel in currentArray) {
                
                if (viewModel.parentId != selectViewModel.deptId) {
                    [resultArray addObject:viewModel];
                    
                    if (viewModel == selectViewModel) {
                        viewModel.state = 0-viewModel.state;
                    }
                }
            }
        } else {
            for (DropDownTableViewViewModel *viewModel in currentArray) {
                [resultArray addObject:viewModel];
                
                if (viewModel == selectViewModel) {
                    viewModel.state = 0-viewModel.state;
                }
            }
        }
    }
    
    return resultArray;
}

+ (NSMutableArray *)reloadSelectArrayWithCurrentArray:(NSArray *)currentArray {
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (DropDownTableViewViewModel *viewModel in currentArray) {
        if (viewModel.state == DropDownTableViewViewModelStateOpen &&
            viewModel.level == DropDownTableViewViewModelLevelThree) {
            [resultArray addObject:viewModel];
        }
    }
    return resultArray;
}

+ (NSMutableArray *)selectAllWithMainArray:(NSArray *)mainArray {
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (DropDownTableViewViewModel *viewModel in mainArray[2]) {
        viewModel.state = DropDownTableViewViewModelStateOpen;
        [resultArray addObject:viewModel];
    }
    return resultArray;
}

+ (void)deselectAllWithMainArray:(NSArray *)mainArray {
    for (DropDownTableViewViewModel *viewModel in mainArray[2]) {
        viewModel.state = DropDownTableViewViewModelStateClosed;
    }
}

@end
