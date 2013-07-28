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
typedef void(^GPGuardFailure)(NSError *error);


@interface GPGuardPost : NSObject

#pragma mark - Configuration Method
+ (void)setPublicAPIKey:(NSString *)apiKey;

#pragma mark - Valdation methods
+ (void)validateAddress:(NSString *)emailAddress
                success:(GPGuardPostEmailValidation)successBlock
                failure:(GPGuardFailure)failureBlock;

+ (void)parseListOfAddresses:(NSString *)listOfAddresses
                     success:(GPGuardPostEmailListParse)successBlock
                     failure:(GPGuardFailure)failureBlock;

@end
