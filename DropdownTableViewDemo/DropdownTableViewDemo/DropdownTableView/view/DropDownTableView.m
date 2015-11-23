//
//  DropDownTableView.m
//  DropdownTableView
//
//  Created by Uncle.Chen on 11/19/15.
//  Copyright © 2015 uncle.chen. All rights reserved.
//

#import "DropDownTableView.h"
#import "DropDownTableViewViewModel.h"
#import "DropDownFirstLevelTableViewCell.h"
#import "DropDownSecondLevelTableViewCell.h"
#import "DropDownThirdLevelTableViewCell.h"

#define DEFBLUECOLOR [UIColor colorWithRed:0 green:0.59 blue:1 alpha:1]
#define DEFYELLOWCOLOR [UIColor colorWithRed:0.89 green:0.56 blue:0 alpha:1]
#define DEFGREENCOLOR [UIColor colorWithRed:0.4 green:0.78 blue:0.33 alpha:1]

@interface DropDownTableView () <UITableViewDelegate, UITableViewDataSource> {
    
    UINib *nibOne;
    UINib *nibTwo;
    UINib *nibThree;
    NSMutableArray *currentArray;
}

@property (nonatomic, strong) DropDownTableViewViewModel *viewModel;

@end

@implementation DropDownTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self addSubview:self.tableView];
        
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
    }
    return self;
}

#pragma mark - setter and getter

- (void)setMainArray:(NSMutableArray *)mainArray {
    if (!_mainArray) {
        _mainArray = mainArray;
        currentArray = mainArray[0];
    }
    [self reloadData];
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return currentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifierOne = @"CellLevelOneReuseIdentifier";
    static NSString *cellIdentifierTwo = @"CellLevelTwoReuseIdentifier";
    static NSString *cellIdentifierThree = @"CellLevelThreeReuseIdentifier";
    
    DropDownTableViewViewModel *cellViewModel = currentArray[indexPath.row];
    
    if (cellViewModel.level == DropDownTableViewViewModelLevelOne) {
        if (!nibOne) {
            nibOne = [UINib nibWithNibName:@"DropDownFirstLevelTableViewCell" bundle:nil];
            [tableView registerNib:nibOne forCellReuseIdentifier:cellIdentifierOne];
        }
        DropDownFirstLevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierOne];
        
        cell.titleLabel.text = cellViewModel.cityName;
        cell.titleLabel.textColor = DEFYELLOWCOLOR;
        return cell;
    } else if (cellViewModel.level == DropDownTableViewViewModelLevelTwo) {
        if (!nibTwo) {
            nibTwo = [UINib nibWithNibName:@"DropDownSecondLevelTableViewCell" bundle:nil];
            [tableView registerNib:nibTwo forCellReuseIdentifier:cellIdentifierTwo];
        }
        DropDownSecondLevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierTwo];
        
        cell.titleLabel.text = cellViewModel.deptName;
        cell.titleLabel.textColor = DEFBLUECOLOR;
        return cell;
    } else {
        if (!nibThree) {
            nibThree = [UINib nibWithNibName:@"DropDownThirdLevelTableViewCell" bundle:nil];
            [tableView registerNib:nibThree forCellReuseIdentifier:cellIdentifierThree];
        }
        DropDownThirdLevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierThree];
        
        cell.titleLabel.text = cellViewModel.name;
        cell.titleLabel.textColor = DEFGREENCOLOR;
        
        if (cellViewModel.state == DropDownTableViewViewModelStateOpen) {
            cell.backgroundColor = DEFGREENCOLOR;
            cell.titleLabel.textColor = [UIColor whiteColor];
        } else {
            cell.backgroundColor = [UIColor clearColor];
            cell.titleLabel.textColor = DEFGREENCOLOR;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    currentArray = ({
        [DropDownTableViewViewModel reloadCurrentArrayWithMainArray:_mainArray
                                                       currentArray:currentArray
                                                          selectRow:indexPath.row];
    });
    _selectArray = ({
        [DropDownTableViewViewModel reloadSelectArrayWithCurrentArray:currentArray];
    });
    [self reloadData];
}

@end
