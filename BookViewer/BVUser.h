//
//  BVUser.h
//  BookViewer
//
//  Created by Air on 6/29/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BVUser : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSMutableArray *books;

@end
