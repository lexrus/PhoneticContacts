//
//  main.m
//  PhoneticContacts
//
//  Created by Lex on 24/11/12.
//  Copyright (c) 2012 Lex Tang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

static NSString *upcaseInitial(NSString *sourceString) {
    NSString *newString = [sourceString copy];
    if ([sourceString length] > 0) {
        newString = [[[sourceString substringToIndex:1] uppercaseString]
                     stringByAppendingString:[sourceString substringFromIndex:1]];
    }

    return newString;
}

static NSString *phonetic(NSString *sourceString) {
    NSMutableString *source = [sourceString mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);

    // Uncomment line below if you don't want the accents. E.g. NínHǎo to NinHao
    //CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripCombiningMarks, NO);

    if (![source isEqualToString:sourceString]) {
        if ([source rangeOfString:@" "].location != NSNotFound) {
            NSArray<NSString *> *phoneticParts = [source componentsSeparatedByString:@" "];
            source = [NSMutableString new];
            for (NSString *part in phoneticParts) {
                [source appendString:upcaseInitial(part)];
            }
        }
        return [upcaseInitial(source) stringByReplacingOccurrencesOfString:@" " withString:@""];
    }

    return NULL;
}

static NSString *kickNull(NSString *string) {
    if (!string) return @"";
    return string;
}

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        ABAddressBook *ab = [ABAddressBook addressBook];
        for (ABPerson *person in ab.people) {
            NSString *first = [person valueForProperty:kABFirstNameProperty];
            NSString *pfirst = NULL;

            NSString *last = [person valueForProperty:kABLastNameProperty];
            NSString *plast = NULL;
            if (first) {
                pfirst = phonetic(first);
                if (pfirst) {
                    [person setValue:pfirst forProperty:kABFirstNamePhoneticProperty];
                }
            }
            if (last) {
                plast = phonetic(last);
                if (plast) {
                    [person setValue:plast forProperty:kABLastNamePhoneticProperty];
                }
            }
            printf("%s", [[NSString stringWithFormat:@"@%@%@=%@%@, ",
                           kickNull(last), kickNull(first),
                           kickNull(plast), kickNull(pfirst)] UTF8String]);
        }
        [ab save];
    }
    return 0;
}

