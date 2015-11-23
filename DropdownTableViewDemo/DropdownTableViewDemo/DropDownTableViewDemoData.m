//
//  DropDownTableViewDemoData.m
//  DropdownTableViewDemo
//
//  Created by Uncle.Chen on 11/22/15.
//  Copyright © 2015 uncle.chen. All rights reserved.
//

#import "DropDownTableViewDemoData.h"
#import "DropDownTableViewViewModel.h"

@implementation DropDownTableViewDemoData

+ (DropDownTableViewDemoData *)sharedDropDownTableViewDemoDataManager {
    static DropDownTableViewDemoData *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}

+ (NSArray *)createData {
    return ({
        @[[[DropDownTableViewDemoData sharedDropDownTableViewDemoDataManager] firstLevelArray],
        [[DropDownTableViewDemoData sharedDropDownTableViewDemoDataManager] secondLevelArray],
        [[DropDownTableViewDemoData sharedDropDownTableViewDemoDataManager] thirdLevelArray]];
    });
}

- (NSMutableArray *)firstLevelArray {
    NSMutableArray *firstLevelArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    NSArray *cityNameArray = @[@"石家庄", @"秦皇岛", @"保定"];
    NSInteger index = 10;
    for (NSString *cityName in cityNameArray) {
        DropDownTableViewViewModel *model = [[DropDownTableViewViewModel alloc] init];
        model.level = DropDownTableViewViewModelLevelOne;
        model.state = DropDownTableViewViewModelStateClosed;
        model.cityId = [NSString stringWithFormat:@"%ld", (long)index];
        model.cityName = cityName;
        [firstLevelArray addObject:model];
        index = index + 10;
    }
    return firstLevelArray;
}

- (NSMutableArray *)secondLevelArray {
    NSMutableArray *secondLevelArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    NSMutableArray *firstLevelArray = [self firstLevelArray];
    for (DropDownTableViewViewModel *firstLevelModel in firstLevelArray) {
        
        NSArray *deptNameArray = @[@"人事部", @"客服部", @"技术部"];
        NSInteger index = 10;
        for (NSString *deptName in deptNameArray) {
            DropDownTableViewViewModel *model = [[DropDownTableViewViewModel alloc] init];
            model.level = DropDownTableViewViewModelLevelTwo;
            model.state = DropDownTableViewViewModelStateClosed;
            model.deptId = ({
                [NSString stringWithFormat:@"%@%ld", firstLevelModel.cityId, (long)index];
            });
            model.deptName = deptName;
            model.cityId = firstLevelModel.cityId;
            model.cityName = firstLevelModel.cityName;
            model.parentId = firstLevelModel.cityId;
            [secondLevelArray addObject:model];
            index = index + 10;
        }
    }
    return secondLevelArray;
}

- (NSMutableArray *)thirdLevelArray {
    NSMutableArray *thirdLevelArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    NSMutableArray *secondLevelArray = [self secondLevelArray];
    for (DropDownTableViewViewModel *secondLevelModel in secondLevelArray) {
        
        NSArray *nameArray = @[@"斧王", @"影魔", @"敌法"];
        NSInteger index = 10;
        for (NSString *name in nameArray) {
            DropDownTableViewViewModel *model = [[DropDownTableViewViewModel alloc] init];
            model.level = DropDownTableViewViewModelLevelThree;
            model.state = DropDownTableViewViewModelStateClosed;
            model.ID = ({
                [NSString stringWithFormat:@"%@%ld", secondLevelModel.deptId, (long)index];
            });
            model.name = name;
            model.deptId = secondLevelModel.deptId;
            model.deptName = secondLevelModel.deptName;
            model.cityId = secondLevelModel.cityId;
            model.cityName = secondLevelModel.cityName;
            model.parentId = secondLevelModel.deptId;
            [thirdLevelArray addObject:model];
            index = index + 10;
        }
    }
    return thirdLevelArray;
}

@end
