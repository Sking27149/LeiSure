//
//  ReadRealListModel.m
//  LeiSure
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "ReadRealListModel.h"
#import <objc/runtime.h>

@implementation ReadRealListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

static unsigned int count;

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        const char *propertyName = property_getName(propertyList[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        [aCoder encodeObject:[self valueForKey:name] forKey:name];
    }
    
    free(propertyList); //通完记得释放该地址。
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        const char *propertyName = property_getName(propertyList[i]); //通过property_getAttributes()方法可以获得每个属性的类名
        NSString *name = [NSString stringWithUTF8String:propertyName];
        [self setValue:[aDecoder decodeObjectForKey:name] forKey:name];
    }
    
    free(propertyList);
    
    return self;
}

@end
