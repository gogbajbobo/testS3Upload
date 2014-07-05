//
//  AWXMLRequestSerializerFixed.h
//  testS3Upload
//
//  Created by Maxim Grigoriev on 05/07/14.
//  Copyright (c) 2014 Sistemium UAB. All rights reserved.
//

#import "AWSURLRequestSerialization.h"

@interface AWXMLRequestSerializerFixed : AWSXMLRequestSerializer

- (BOOL)__serializeRequest:(NSMutableURLRequest *)request headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters error:(NSError * __autoreleasing *)error;

@end
