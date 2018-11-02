//
//  RNSimpleMercadopagoCheckout.swift
//  RNSimpleMercadopagoCheckout
//
//  Created by Luis Daher on 31/10/18.
//  Copyright © 2018 Facebook. All rights reserved.B
//

import Foundation
import MercadoPagoSDK

@objc(RNSimpleMercadopagoCheckout)
class RNSimpleMercadopagoCheckout: NSObject {
    @objc func startCheckout(_ publicKey: String, prefId: String , resolver resolve:RCTPromiseResolveBlock,rejecter reject:RCTPromiseRejectBlock) -> Void {
//        print(MercadoPagoSDKVersionNumber);
        MercadoPagoCheckout.init(builder: MercadoPagoCheckoutBuilder.init(publicKey: publicKey, preferenceId: prefId)).start(navigationController: self.navigationController!)
        resolve(true);
    }

}
