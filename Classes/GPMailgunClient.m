//
//  GPMailgunClient.m
//  GuardPost-ObjectiveC
//
//  Created by Sam Davies on 27/07/2013.
//  Copyright (c) 2013 sammyd. All rights reserved.
//

#import "GPMailgunClient.h"
#import <AFNetworking/AFJSONRequestOperation.h>

static NSString * const kGPMailgunClientBaseURL = @"https://api.mailgun.net/v2/";

@implementation GPMailgunClient

+ (instancetype)sharedClient
{
    static GPMailgunClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[GPMailgunClient alloc] initWithBaseURL:[NSURL URLWithString:kGPMailgunClientBaseURL]];
    });
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if(!self) {
        return nil;
    }
    
    // We're talking in JSON
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

#pragma mark - Property overrides
- (void)setPublicAPIKey:(NSString *)publicAPIKey
{
    if(publicAPIKey != _publicAPIKey) {
        _publicAPIKey = publicAPIKey;
        [self setAuthorizationHeaderWithUsername:@"api" password:_publicAPIKey];
    }
}

@end
