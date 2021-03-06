//
//  CDAMapViewController.m
//  ContentfulSDK
//
//  Created by Boris Bügling on 02/04/14.
//
//

#import <ContentfulDeliveryAPI/ContentfulDeliveryAPI.h>
#import <MapKit/MapKit.h>

#import "CDAMapViewController.h"
#import "CDAUtilities.h"

@interface CDAMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, copy) NSString* title;

@end

#pragma mark -

@implementation CDAMapAnnotation

@synthesize coordinate = _coordinate;
@synthesize subtitle = _subtitle;
@synthesize title = _title;

@end

#pragma mark -

@interface CDAMapViewController ()

@property (nonatomic, readonly) NSString* cacheFileName;
@property (nonatomic) CDAArray* entries;
@property (nonatomic) MKMapView* mapView;

@end

#pragma mark -

@implementation CDAMapViewController

-(NSString *)cacheFileName {
    return CDACacheFileNameForQuery(CDAResourceTypeEntry, self.query);
}

-(void)handleCaching {
    if (self.offlineCaching) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.entries writeToFile:self.cacheFileName];
        });
    }
}

-(void)refresh {
    for (CDAEntry* entry in self.entries.items) {
        CDAMapAnnotation* annotation = [CDAMapAnnotation new];
        
        if (self.coordinateFieldIdentifier) {
            annotation.coordinate = [entry CLLocationCoordinate2DFromFieldWithIdentifier:self.coordinateFieldIdentifier];
        }
        
        if (self.subtitleFieldIdentifier) {
            annotation.subtitle = entry.fields[self.subtitleFieldIdentifier];
        }
        
        if (self.titleFieldIdentifier) {
            annotation.title = entry.fields[self.titleFieldIdentifier];
        }
        
        [self.mapView addAnnotation:annotation];
    }
}

-(void)showError:(NSError*)error {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                        message:error.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil];
    [alertView show];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSAssert(self.client, @"You need to supply a client instance to %@.",
             NSStringFromClass([self class]));
    
    [self.client fetchEntriesMatching:self.query
                              success:^(CDAResponse *response, CDAArray *array) {
                                  self.entries = array;
                                  
                                  [self refresh];
                                  [self handleCaching];
                              }
                              failure:^(CDAResponse *response, NSError *error) {
                                  if (CDAIsNoNetworkError(error)) {
                                      self.entries = [CDAArray readFromFile:self.cacheFileName
                                                                     client:self.client];
                                      
                                      [self refresh];
                                      return;
                                  }
                                  
                                  [self showError:error];
                              }];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mapView];
}

@end
