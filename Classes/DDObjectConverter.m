//
//  DDObjectConverter.m
//  DDFoundation
//
//  Created by Dmitry Danilov on 03.04.16.
//  Copyright © 2016 Dmitry Danilov. All rights reserved.
//

#import "DDObjectConverter.h"

@implementation NSObject(DDObjectConverter)


- (NSInteger)convertToInteger {
    if (![self isEqual:[NSNull null]])
        return [(id)self integerValue];
    else
        return NSNotFound;
}

- (int)convertToInt {
    if (![self isEqual:[NSNull null]])
        return [(id)self intValue];
    else
        return NSNotFound;
}

- (long)convertToLong {
    if (![self isEqual:[NSNull null]])
        return [(id)self longValue];
    else
        return NSIntegerMax;
}

- (NSString *)convertToString {
    if (![self isEqual:[NSNull null]])
        return [[NSString stringWithFormat:@"%@",(id)self] copy];
    else
        return @"";
}

- (NSArray *)convertToArray {
    if (![self isEqual:[NSNull null]] && [self isKindOfClass:[NSArray class]])
        return (NSArray *)self;
    else
        return nil;
}


- (NSDictionary *)convertToDictionary {
    if (![self isEqual:[NSNull null]] && [self isKindOfClass:[NSDictionary class]])
        return (NSDictionary *)self;
    else
        return nil;
}

- (float)convertToFloat {
    if (![self isEqual:[NSNull null]])
        return [(id)self floatValue];
    else
        return 0;
}

void mainCall(void(^block)()) {
    if (block == nil)
        return;
    if ([[NSThread currentThread] isMainThread])
        block();
    else
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           block();
                       });
}


@end
