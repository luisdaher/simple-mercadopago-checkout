#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif

// @interface RNSimpleMercadopagoCheckout : NSObject <RCTBridgeModule>
//
// @end


@interface RCT_EXTERN_MODULE(RNSimpleMercadopagoCheckout, NSObject)

RCT_EXTERN_METHOD(startCheckout:(NSString *)publicKey prefId:(NSString *)prefId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

@end
