//
//  GPMailgunClient.h
//  GuardPost-ObjectiveC
//
//  Created by Sam Davies on 27/07/2013.
//  Copyright (c) 2013 sammyd. All rights reserved.
//

#import "AFHTTPClient.h"

@interface GPMailgunClient : AFHTTPClient

+ (instancetype)sharedClient;

@property (nonatomic, strong) NSString *publicAPIKey;

@end
