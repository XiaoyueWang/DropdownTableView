//
//  DropdownTableViewDemo.h
//  DropdownTableViewDemo
//
//  Created by Uncle.Chen on 11/22/15.
//  Copyright © 2015 uncle.chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropdownTableViewDemo : UIView

typedef void (^ConfirmBlock)(NSArray *selectArray, NSArray *allArray);
@property (nonatomic, copy) ConfirmBlock confirmBlock;

@end
