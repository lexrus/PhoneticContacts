//
//  main.m
//  PhoneticContacts
//
//  Created by Lex on 24/11/12.
//  Copyright (c) 2012 Lex Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

static NSString *phonetic(NSString *sourceString) {
    NSMutableString *source = [sourceString mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    return source;
}

static NSString *kickNull(NSString *string) {
    if (!string) return @"";
    return string;
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        ABAddressBook *ab = [ABAddressBook addressBook];
        NSMutableArray *myContacts = [NSMutableArray array];
        for (ABPerson *person in ab.people) {
            NSString *first = [person valueForProperty:kABFirstNameProperty];
            NSString *last = [person valueForProperty:kABLastNameProperty];
            NSMutableString *pinyin = [NSMutableString string];
            if (first) {
                [pinyin appendString:phonetic(first)];
                [person setValue:phonetic(first) forProperty:kABFirstNamePhoneticProperty];
            }
            if (last) {
                [pinyin appendString:phonetic(last)];
                [person setValue:phonetic(last) forProperty:kABLastNamePhoneticProperty];
            }
            [myContacts addObject:pinyin];
            printf("%s", [[NSString stringWithFormat:@"@%@%@=%@%@, ",
                           kickNull(first), kickNull(last),
                           phonetic(kickNull(first)), phonetic(kickNull(last))] UTF8String]);
        }
        [ab save];
        
    }
    return 0;
}

