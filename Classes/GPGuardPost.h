//
//  GPGuardPost.h
//  GuardPost-ObjectiveC
//
//  Created by Sam Davies on 27/07/2013.
//  Copyright (c) 2013 sammyd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GPGuardPostEmailValidation)(BOOL validity, NSString *suggestion);
typedef void(^GPGuardPostEmailListParse)(NSArray *parsed, NSArray *unparseable);


@interface GPGuardPost : NSObject

#pragma mark - Configuration Method
+ (void)setPublicAPIKey:(NSString *)apiKey;

#pragma mark - Valdation methods
+ (void)validateAddress:(NSString *)emailAddress resultBlock:(GPGuardPostEmailValidation)resultBlock;
+ (void)parseListOfAddresses:(NSString *)listOfAddresses resultBlock:(GPGuardPostEmailListParse)resultBlock;

@end
