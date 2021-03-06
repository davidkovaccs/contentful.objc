//
//  CDAConfiguration.h
//  ContentfulSDK
//
//  Created by Boris Bügling on 04/03/14.
//
//

#import <Foundation/Foundation.h>

/**
 Class representing additional configuration options for a `CDAClient`.
 */
@interface CDAConfiguration : NSObject

/** @name Creating a configuration */

/**
 *  Creating a configuration with default parameters.
 *
 *  @return A configuration initialized with default parameters.
 */
+(instancetype)defaultConfiguration;

/** @name Configuring parameters */

/** If `YES`, a secure HTTPS connection will be used instead of regular HTTP. Default value: `YES` */
@property (nonatomic) BOOL secure;
/** The server address to use for accessing any resources. Default value: "http://cdn.contentful.com" */
@property (nonatomic) NSString* server;

/** @name Configure Preview Mode */

/** Preview mode allows retrieving unpublished Resources. 
 
 To use it, you have to obtain a special access
 token from [here](https://www.contentful.com/developers/documentation/content-management-api/#getting-started). 
 
 In preview mode, data can be invalid, because no validation is performed on unpublished entries. Your
 app needs to deal with that. Be aware that the access token is read-write and should in no case be
 shipped with a production app.
 */
@property (nonatomic) BOOL previewMode;

@end
