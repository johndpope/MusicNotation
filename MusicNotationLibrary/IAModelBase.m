//
//  ModelBaseClass.m
//  RKTestApp
//
//  Created by Omar on 8/25/12.
//  Copyright (c) 2012 InfusionApps. All rights reserved.
//

#import "IAModelBase.h"
#import <objc/runtime.h>
#import "NSString+Ruby.h"

@implementation IAModelBase (JSONDescription)

- (NSString*)description;
{
    NSError* writeError = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:[self dictionarySerialization]
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&writeError];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    //    return jsonString;
    return [[NSString stringWithFormat:@"<%@:%p>\n", self.class, self]
        concat:[NSString stringWithFormat:@"%@", jsonString]];
}

- (NSDictionary*)dictionarySerialization;
{
    return [self dictionaryWithValuesForKeyPaths:@[]];
}

@end

@interface IAModelBase ()
@property (nonatomic, strong) NSDictionary* dictionaryOfKeysToKeys;
@property (nonatomic, strong) NSDictionary* dictionaryOfKeysClasses;
@end

@implementation IAModelBase

- (instancetype)init
{
    self = [self initWithDictionary:nil];
    if(self)
    {
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString*)key;
{
}

- (void)setValue:(id)value forKey:(NSString*)key;
{
    NSString* realKey = [_dictionaryOfKeysToKeys valueForKey:key];

    if(!realKey)
    {
        realKey = key;
    }

    if([self isArrayOrDictionary:value])
    {
        [self setValue:value forModelKey:realKey];
    }
    else
    {
        [super setValue:value forKey:realKey];
    }
}

- (BOOL)isArrayOrDictionary:(id)value;
{
    return [value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]];
}

- (Class)classForKey:(NSString*)key;
{
    Class objectClass = [self class];
    NSString* accessorKey = key;

    objc_property_t theProperty = class_getProperty(objectClass, [accessorKey UTF8String]);

    if(!theProperty)
        return nil;

    const char* propertyAttrs = property_getAttributes(theProperty);
    NSString* propertyString = [NSString stringWithUTF8String:propertyAttrs];

    NSString* startingString = @"T@\"";
    NSString* endingString = @"\",";

    NSUInteger startingIndex = [propertyString rangeOfString:startingString].location + startingString.length;

    NSString* propType = [propertyString substringFromIndex:startingIndex];

    NSUInteger endingIndex = [propType rangeOfString:endingString].location;

    propType = [propType substringToIndex:endingIndex];

    Class propClass = NSClassFromString(propType);

    return propClass;
}

- (void)setValue:(id)value forModelKey:(NSString*)key;
{
    Class cls = [self classForKey:key];

    BOOL isArray = [cls instancesRespondToSelector:@selector(initWithObjects:)];

    if(isArray)
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        BOOL isModelArray = [cls instancesRespondToSelector:@selector(classForModelBase)];
#pragma clang diagnostic pop

        if(isModelArray)
        {
            id object = [[cls alloc] initWithArray:value];
            [super setValue:object forKey:key];
        }
        else
        {
            Class arrayElementClass = [self classForKeyInCollection:key];
            if(arrayElementClass)
            {
                [self fillArrayWithArray:value forKey:key withEntryClass:arrayElementClass];
            }
            else
            {
                [super setValue:value forKey:key];
            }
        }
    }
    else
    {   // Dictionary
        BOOL isModel = [cls instancesRespondToSelector:@selector(classForKeyInCollection:)];
        if(isModel)
        {
            [self fillObjectWithDictionary:value forKey:key withEntryClass:cls];
        }
        else
        {
            [super setValue:value forKey:key];
        }
    }
}

//- (Class)classForModelBase; {
//    return [self class];
//}

- (void)fillObjectWithDictionary:(NSDictionary*)dic forKey:(NSString*)key withEntryClass:(Class) class;
{
    id modelObject = [[class alloc] initWithDictionary:dic];
    [super setValue:modelObject forKey:key];
}

- (void)fillArrayWithArray:(NSArray*)array forKey:(NSString*)key withEntryClass:(Class) class;
{
    NSMutableArray* retArray = [[NSMutableArray alloc] init];

    for(id arrayEntry in array)
    {
        id entry = [[class alloc] initWithDictionary:arrayEntry];
        [retArray addObject:entry];
    }

    [super setValue:retArray forKey:key];
}

- (Class)classForKeyInCollection:(NSString*)key;
{
    NSString* className = [_dictionaryOfKeysClasses objectForKey:key];

    if(!className)
    {
        return [self classForKeyByProcessingName:key];
    }
    else
    {
        return NSClassFromString(className);
    }

    return nil;
}

- (Class)classForKeyByProcessingName:(NSString*)key;
{
    NSArray* suffixes = CollectionSuffiex;
    NSString* keyWithNoSuffix = nil;

    if(key)
    {
        for(NSString* suffix in suffixes)
        {
            if([key rangeOfString:suffix].location != NSNotFound)
            {
                keyWithNoSuffix = [self keyNameByRemovingSuffixOrNil:key suffix:suffix];
                break;
            }
        }
    }

    if(!keyWithNoSuffix)
    {
        keyWithNoSuffix = [self keyByRemovingFinalSuffixOrNil:key];
    }

    if(keyWithNoSuffix)
    {
        keyWithNoSuffix = [keyWithNoSuffix capitalizedString];
    }

    return NSClassFromString(keyWithNoSuffix);
}

- (NSString*)keyNameByRemovingSuffixOrNil:(NSString*)key suffix:(NSString*)suffix;
{
    NSUInteger location = [key rangeOfString:suffix].location;
    NSString* keyWithNoSuffix = [key substringToIndex:location];

    return keyWithNoSuffix;
}

- (NSString*)keyByRemovingFinalSuffixOrNil:(NSString*)key
{
    NSString* finalSuffix = [key substringFromIndex:key.length - 1];
    NSString* keyWithNoSuffix = nil;

    if([finalSuffix isEqualToString:@"s"])
    {
        keyWithNoSuffix = [key substringToIndex:key.length - 1];
    }

    return keyWithNoSuffix;
}

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
{
    self = [super init];

    if(self)
    {
        self.dictionaryOfKeysToKeys = [self propertiesToDictionaryEntriesMapping];
        self.dictionaryOfKeysClasses = [self classesForArrayEntries];

        //        [self setValuesForKeysWithDictionary:dictionary];
        [self setValuesForKeyPathsWithDictionary:dictionary];
    }

    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    /*
     //create a dictionary that maps the correct property name
     //with the parameter name returned form json

     //<object of the retruned dictionary>
     //staffID = is the correct name of the property

     //<key of the retruned dictionary>
     //id = is the name of the key in the dictionary that you want to map

    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"staffID",
            @"id",
            nil];
     */

    if(!_propertiesToDictionaryEntriesMapping)
    {
        _propertiesToDictionaryEntriesMapping = [NSMutableDictionary dictionary];
    }

    return _propertiesToDictionaryEntriesMapping;
}

- (NSDictionary*)classesForArrayEntries;
{
    /*
     //Since objective c does not have strongly templated collections
     //This is a work around to template a collection
     //You will have to retrun a dictionary that has the following

     //<object of the retruned dictionary>
     //Experience = the name of the class for the selected property

     //<key of the retruned dictionary>
     //experiences = name of the property

     //the property will be like
     //@property NSArray *experiences;

     //using ModelBaseClass experiences will contain an array of
     //Experience objects

    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"Experience",
            @"experiences",
            nil];
     */
    return nil;
}

//======================================================================================================================

- (void)setValuesForKeyPathsWithDictionary:(NSDictionary*)keyedValues;
{
    for(NSString* key_keyPath in keyedValues.allKeys)
    {
        id object = [keyedValues objectForKey:key_keyPath];
        //        if([object isNotEqualTo:[NSNull null]])
        //        {
        [self setValue:object forKeyPath:key_keyPath];
        //        }
        //        else
        //        {
        //            [self setValue:nil forKeyPath:key_keyPath];
        //        }
    }
}

- (NSDictionary*)dictionaryWithValuesForKeyPaths:(NSArray*)keyPaths;
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    for(NSString* keyPath in keyPaths)
    {
        // TODO: crashes if self does not have value
        [dict setObject:[self valueForKeyPath:keyPath] forKey:keyPath];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
