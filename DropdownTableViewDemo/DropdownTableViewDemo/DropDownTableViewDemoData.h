//
//  DropDownTableViewDemoData.h
//  DropdownTableViewDemo
//
//  Created by Uncle.Chen on 11/22/15.
//  Copyright © 2015 uncle.chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DropDownTableViewDemoData : NSObject

+ (DropDownTableViewDemoData *)sharedDropDownTableViewDemoDataManager;
+ (NSArray *)createData;

@end
