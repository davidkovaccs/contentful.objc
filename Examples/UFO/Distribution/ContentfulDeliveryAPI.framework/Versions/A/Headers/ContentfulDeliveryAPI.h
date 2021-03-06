//
//  ContentfulDeliveryAPI.h
//  ContentfulSDK
//
//  Created by Boris Bügling on 04/03/14.
//
//

#import <Foundation/Foundation.h>

#import <ContentfulDeliveryAPI/CDAArray.h>
#import <ContentfulDeliveryAPI/CDAAsset.h>
#import <ContentfulDeliveryAPI/CDAClient.h>
#import <ContentfulDeliveryAPI/CDAConfiguration.h>
#import <ContentfulDeliveryAPI/CDAContentType.h>
#import <ContentfulDeliveryAPI/CDAEntry.h>
#import <ContentfulDeliveryAPI/CDAField.h>
#import <ContentfulDeliveryAPI/CDARequest.h>
#import <ContentfulDeliveryAPI/CDAResponse.h>
#import <ContentfulDeliveryAPI/CDASpace.h>
#import <ContentfulDeliveryAPI/CDASyncedSpace.h>

#if TARGET_OS_IPHONE
#import <ContentfulDeliveryAPI/CDAEntriesViewController.h>
#import <ContentfulDeliveryAPI/CDAFieldsViewController.h>
#import <ContentfulDeliveryAPI/CDAMapViewController.h>
#import <ContentfulDeliveryAPI/CDAResourceCell.h>
#import <ContentfulDeliveryAPI/CDAResourcesCollectionViewController.h>
#import <ContentfulDeliveryAPI/CDAResourcesViewController.h>
#endif

extern NSString* const CDAErrorDomain;
