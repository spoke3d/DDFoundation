//
//  DDObjectConverter.h
//  DDFoundation
//
//  Created by Dmitry Danilov on 03.04.16.
//  Copyright © 2016 Dmitry Danilov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(DDObjectConverter)

- (NSInteger)convertToInteger;
- (int)convertToInt;
- (long)convertToLong;
- (NSString *)convertToString;
- (NSArray *)convertToArray;
- (NSDictionary *)convertToDictionary;
- (float)convertToFloat;

void mainCall(void(^block)());

@end
