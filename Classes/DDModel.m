//
//  DDModel.m
//  DDFoundation
//
//  Created by Dmitry Danilov on 23.07.16.
//  Copyright © 2016 Dmitry Danilov. All rights reserved.
//

#import "DDModel.h"
#import <objc/runtime.h>

@implementation DDModel

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        unsigned int propertyCount = 0;
        objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
        for (unsigned int i = 0; i < propertyCount; ++i)
        {
            NSString *string_name = [NSString stringWithUTF8String:property_getName(properties[i])];
            NSObject *object = [aDecoder decodeObjectForKey:string_name];
            if (object != nil)
                [self setValue:[aDecoder decodeObjectForKey:string_name] forKey:string_name];
        }
        free(properties);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    for (unsigned int i = 0; i < propertyCount; ++i)
    {
        NSString *string_name = [NSString stringWithUTF8String:property_getName(properties[i])];
        [aCoder encodeObject:[self valueForKey:string_name] forKey:string_name];
    }
    free(properties);
}



- (BOOL)isEqual:(id)object
{
    unsigned int selfPropertyCount = 0;
    objc_property_t *selfProperties = class_copyPropertyList([self class], &selfPropertyCount);
    
    unsigned int objectPropertyCount = 0;
    objc_property_t *objectProperties = class_copyPropertyList([object class], &objectPropertyCount);
    
    if(selfPropertyCount != objectPropertyCount)
        return NO;
    
    BOOL result = YES;
    for(unsigned int i = 0; i<selfPropertyCount; i++)
    {
        NSString *selfPropertyName = [NSString stringWithUTF8String:property_getName(selfProperties[i])];
        NSString *objectPropertyName = [NSString stringWithUTF8String:property_getName(objectProperties[i])];
        
        if(![selfPropertyName isEqualToString:objectPropertyName])
        {
            result = NO;
            break;
        }
        
        if(![object respondsToSelector:NSSelectorFromString(selfPropertyName)])
        {
            result = NO;
            break;
        }
        
        NSObject *selfObject = [self valueForKey:selfPropertyName];
        NSObject *objectObject = [object valueForKey:selfPropertyName];
        
        if(selfObject !=
           nil && selfObject !=nil)
            if (![selfObject isEqual:objectObject])
            {
                result = NO;
                break;
            }
    }
    
    free(selfProperties);
    free(objectProperties);
    
    if (result)
    {
        selfPropertyCount = 0;
        selfProperties = class_copyPropertyList([self superclass], &selfPropertyCount);
        
        objectPropertyCount = 0;
        objectProperties = class_copyPropertyList([object superclass], &objectPropertyCount);
        
        if(selfPropertyCount != objectPropertyCount)
        {
            result = NO;
        }
        
        for(unsigned int i = 0; i<selfPropertyCount; i++)
        {
            NSString *selfPropertyName = [NSString stringWithUTF8String:property_getName(selfProperties[i])];
            NSString *objectPropertyName = [NSString stringWithUTF8String:property_getName(objectProperties[i])];
            
            if(![selfPropertyName isEqualToString:objectPropertyName])
            {
                result = NO;
                break;
            }
            
            if(![object respondsToSelector:NSSelectorFromString(selfPropertyName)])
            {
                result = NO;
                break;
            }
            
            NSObject *selfObject = [self valueForKey:selfPropertyName];
            NSObject *objectObject = [object valueForKey:selfPropertyName];
            
            if(selfObject !=
               nil && selfObject !=nil)
                if (![selfObject isEqual:objectObject])
                {
                    result = NO;
                    break;
                }
        }
        
        free(selfProperties);
        free(objectProperties);
    }
    
    return result;
}

- (NSString *)description
{
    NSString *result = [NSString stringWithFormat:@"%@ = {\r", NSStringFromClass([self class])];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    for (unsigned int i = 0; i < propertyCount; ++i)
    {
        NSString *string_name = [NSString stringWithUTF8String:property_getName(properties[i])];
        result = [result stringByAppendingFormat:@"%@ = %@\r", string_name, [[self valueForKey:string_name] description]];
    }
    free(properties);
    result = [result stringByAppendingString:@"}"];
    return result;
}

@end
