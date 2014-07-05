//
//  AWXMLRequestSerializerFixed.m
//  testS3Upload
//
//  Created by Maxim Grigoriev on 05/07/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import "AWXMLRequestSerializerFixed.h"

@implementation AWXMLRequestSerializerFixed


#pragma clang diagnostic push
#pragma ide diagnostic ignored "InfiniteRecursion"

- (BOOL)__serializeRequest:(NSMutableURLRequest *)request headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters error:(NSError * __autoreleasing *)error {
    
    BOOL superResult = [super serializeRequest:request headers:headers parameters:parameters error:error];
    NSString * contentType = parameters[@"ContentType"];
    
    if (contentType) {
        [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    }
    
    return superResult;
    
}
#pragma clang diagnostic pop


@end
