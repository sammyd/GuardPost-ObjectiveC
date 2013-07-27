//
//  GPGuardPost.m
//  GuardPost-ObjectiveC
//
//  Created by Sam Davies on 27/07/2013.
//  Copyright (c) 2013 sammyd. All rights reserved.
//

#import "GPGuardPost.h"
#import "GPMailgunClient.h"

@implementation GPGuardPost

+ (void)setPublicAPIKey:(NSString *)apiKey
{
    [[GPMailgunClient sharedClient] setPublicAPIKey:apiKey];
}

#pragma mark - API Methods
+ (void)validateAddress:(NSString *)emailAddress resultBlock:(GPGuardPostEmailValidation)resultBlock
{
    NSString *endpointPath = @"address/validate";
    
    GPMailgunClient *client = [GPMailgunClient sharedClient];
    
    [client getPath:endpointPath
         parameters:@{@"address": emailAddress}
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                // We got the response we wanted.
                
                // Extract the values we care about
                BOOL valid = [[responseObject valueForKey:@"is_valid"] boolValue];
                
                // The suggestion might not exist
                NSString *suggestion = [self checkForNull:[responseObject valueForKey:@"did_you_mean"]];
                
                // Call the result_block with the correct results
                resultBlock(valid, suggestion);
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                // This didn't work
                NSLog(@"There was a problem validating the email address.");
            }];
}

+ (void)parseListOfAddresses:(NSString *)listOfAddresses resultBlock:(GPGuardPostEmailListParse)resultBlock
{
    NSString *endpointPath = @"address/parse";
    
    GPMailgunClient *client = [GPMailgunClient sharedClient];
    
    [client getPath:endpointPath
         parameters:@{@"addresses": listOfAddresses}
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                // Success
                NSArray *parsed = [self checkForNull:[responseObject valueForKey:@"parsed"]];
                NSArray *unparseable = [self checkForNull:[responseObject valueForKey:@"unparseable"]];

                // And return the results
                resultBlock(parsed, unparseable);
            }
            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                // Failure
                NSLog(@"There was a problem parsing the email address list");
            }];
}

#pragma mark - Utility methods
+ (id)checkForNull:(id)value
{
    if([value isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return value;
}


@end
