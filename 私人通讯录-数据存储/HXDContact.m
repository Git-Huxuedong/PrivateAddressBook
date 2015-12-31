//
//  HXDContact.m
//  私人通讯录-数据存储
//
//  Created by huxuedong on 15/10/3.
//  Copyright © 2015年 胡学东. All rights reserved.
//

#import "HXDContact.h"
#define kName @"name"
#define kPhone @"phone"

@implementation HXDContact

+ (instancetype)contactWithName:(NSString *)name andPhone:(NSString *)phone {
    HXDContact *contact = [[HXDContact alloc] init];
    contact.name = name;
    contact.phone = phone;
    return contact;
}

//实现协议中的方法，用于存储数据到文件中
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:kName];
    [aCoder encodeObject:self.phone forKey:kPhone];
}

//实现协议中的方法，用于读取文件中的数据
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:kName];
        self.phone = [aDecoder decodeObjectForKey:kPhone];
    }
    return self;
}

@end
