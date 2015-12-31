//
//  HXDContact.h
//  私人通讯录-数据存储
//
//  Created by huxuedong on 15/10/3.
//  Copyright © 2015年 胡学东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXDContact : NSObject <NSCoding>

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *phone;

+ (instancetype)contactWithName:(NSString *)name andPhone:(NSString *)phone;

@end
