//
//  GuardPost_ObjectiveCTests.m
//  GuardPost-ObjectiveCTests
//
//  Created by Sam Davies on 27/07/2013.
//  Copyright (c) 2013 sammyd. All rights reserved.
//

#import "GuardPost_ObjectiveCTests.h"
#import "GPGuardPost+Testing.h"
#import <SenTestingKitAsync/SenTestingKitAsync.h>

@implementation GuardPost_ObjectiveCTests

- (void)setUp
{
    [super setUp];
    [GPGuardPost setPublicAPIKey:@"real-pub-key"];
}

- (void)test_attemptSampleEmailAddressAsync
{
    [GPGuardPost validateAddress:@"tony.tiger@gmial.com"
                         success:^(BOOL validity, NSString *suggestion) {
                             STAssertTrue(validity, @"This email is valid");
                             STAssertEqualObjects(suggestion, @"tony.tiger@gmail.com", @"Email suggestion should work");
                             STSuccess();
                         }
                         failure:NULL];
    
    STFailAfter(2, @"Response should be within 2s");
}

- (void)test_EmailValidation_WithoutAPIKey_ShouldThrow
{
    // Remove the API Key
    [GPGuardPost resetAPIKey];
    STAssertThrows([GPGuardPost validateAddress:@"sample@email.com" success:NULL failure:NULL], @"Without an API Key we should throw and exception");
}

- (void)test_ListParsing_WithoutAPIKey_ShouldThrow
{
    // Remove the API Key
    [GPGuardPost resetAPIKey];
    STAssertThrows([GPGuardPost parseListOfAddresses:@"sample@email.com" success:NULL failure:NULL], @"Without an API Key we should throw an exception");
}

- (void)test_EmailValidation_WithNullBlock_ShouldNotThrow
{
    STAssertNoThrow([GPGuardPost validateAddress:@"sample@email.com" success:NULL failure:NULL], @"NULL block should not throw");
}

- (void)test_ListParsing_WithNullBlock_ShouldNotThrow
{
    STAssertNoThrow([GPGuardPost parseListOfAddresses:@"sample@email.com" success:NULL failure:NULL], @"NULL block should not throw");
}

- (void)test_EmailValidation_WithIncorrectAPIKey_ShouldProvideHelpfulError_Async
{
    [GPGuardPost setPublicAPIKey:@"invalidAPIKey"];
    [GPGuardPost validateAddress:@"sample@email.com" success:NULL failure:^(NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        STSuccess();
    }];
    STFailAfter(2, @"2s timeout");
}

- (void)test_ListPartsing_WithIncorrectAPIKey_ShouldProvideHelpfulError_Async
{
    [GPGuardPost setPublicAPIKey:@"invalidAPIKey"];
    [GPGuardPost parseListOfAddresses:@"email@sample.com" success:NULL failure:^(NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        STSuccess();
    }];
    STFailAfter(2, @"2s timeout");
}

@end
