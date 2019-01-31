#import "RNPermissionHandlerCamera.h"

@import AVFoundation;

@implementation RNPermissionHandlerCamera

+ (NSArray<NSString *> * _Nullable)usageDescriptionKeys {
  return @[@"NSCameraUsageDescription"];
}

- (void)checkWithResolver:(void (^)(RNPermissionStatus status))resolve
             withRejecter:(void (__unused ^)(NSError *error))reject {
  switch ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]) {
    case AVAuthorizationStatusNotDetermined:
      return resolve(RNPermissionStatusNotDetermined);
    case AVAuthorizationStatusRestricted:
      return resolve(RNPermissionStatusRestricted);
    case AVAuthorizationStatusDenied:
      return resolve(RNPermissionStatusDenied);
    case AVAuthorizationStatusAuthorized:
      return resolve(RNPermissionStatusAuthorized);
  }
}

- (void)requestWithOptions:(__unused NSDictionary * _Nullable)options
              withResolver:(void (^)(RNPermissionStatus status))resolve
              withRejecter:(void (^)(NSError *error))reject {
  [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(__unused BOOL granted) {
    [self checkWithResolver:resolve withRejecter:reject];
  }];
}

@end