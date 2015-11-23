//
//  ViewController.m
//  DropdownTableViewDemo
//
//  Created by Uncle.Chen on 11/22/15.
//  Copyright © 2015 uncle.chen. All rights reserved.
//

#import "ViewController.h"
#import "DropdownTableViewDemo.h"
#import "DropDownTableViewViewModel.h"
#import "DropDownFirstLevelTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {

    NSArray *globalSelectArray;
    UINib *nib;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonClickAction:(UIButton *)sender {
    [self loadDropDownTableView];
}

- (void)loadDropDownTableView {
    DropdownTableViewDemo *dropDownTableViewDemo = [[DropdownTableViewDemo alloc] initWithFrame:({
        CGRectMake(0, 20.f,
                   CGRectGetWidth([UIScreen mainScreen].bounds),
                   CGRectGetHeight([UIScreen mainScreen].bounds)-20.f);
    })];
    dropDownTableViewDemo.confirmBlock = ^(NSArray *selectArray, NSArray *allArray) {
        globalSelectArray = selectArray;
        [self.resultTableView reloadData];
    };
    [self.view addSubview:dropDownTableViewDemo];
    
    self.resultTableView.delegate = self;
    self.resultTableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return globalSelectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CellIdentifier";
    if (!nib) {
        nib = [UINib nibWithNibName:@"DropDownFirstLevelTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    }
    DropDownFirstLevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    DropDownTableViewViewModel *viewModel = globalSelectArray[indexPath.row];
    cell.titleLabel.text = ({
        [[[[viewModel.cityName stringByAppendingString:@"-"]
           stringByAppendingString:viewModel.deptName]
          stringByAppendingString:@"-"]
         stringByAppendingString:viewModel.name];
    });
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
