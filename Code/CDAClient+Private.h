//
//  CDAClient.h
//  ContentfulSDK
//
//  Created by Boris Bügling on 04/03/14.
//
//

#import <ContentfulDeliveryAPI/CDAClient.h>

@class CDAContentTypeRegistry;
@class CDARequestOperationManager;

@interface CDAClient ()

@property (nonatomic, readonly) NSString* protocol;
@property (nonatomic) BOOL synchronizing;

-(CDAConfiguration*)configuration;
-(CDAContentTypeRegistry*)contentTypeRegistry;
-(CDAArray*)fetchContentTypesMatching:(NSDictionary*)query synchronouslyWithError:(NSError**)error;
-(CDASpace*)fetchSpaceSynchronouslyWithError:(NSError**)error;
-(CDARequestOperationManager*)requestOperationManager;
-(CDASpace*)space;

@end
