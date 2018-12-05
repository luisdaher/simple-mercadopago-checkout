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
class RNSimpleMercadopagoCheckout: RCTEventEmitter {

    var checkoutResolver:RCTPromiseResolveBlock!
    var checkoutRejecter:RCTPromiseRejectBlock!

    @objc override static func requiresMainQueueSetup() -> Bool {
        return false
    }

    @objc func startCheckout(_ publicKey: String, prefId: String , resolver resolve:@escaping RCTPromiseResolveBlock,rejecter reject:@escaping RCTPromiseRejectBlock) -> Void {
        let builder = MercadoPagoCheckoutBuilder.init(publicKey: publicKey, preferenceId: prefId)
        let navController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        checkoutResolver = resolve
        checkoutRejecter = reject
        navController.setNavigationBarHidden(false, animated: false)

        builder.setLanguage("pt-BR")
        builder.setColor(checkoutColor: UIColor.green)
        DispatchQueue.main.async(execute: {
            let checkout = MercadoPagoCheckout.init(builder: builder)

            checkout.start(navigationController: UIApplication.shared.keyWindow?.rootViewController as! UINavigationController, lifeCycleProtocol: self)
        })
    }

}

// MARK: Optional Lifecycle protocol implementation example.
extension RNSimpleMercadopagoCheckout: PXLifeCycleProtocol {

    @objc override func supportedEvents() -> [String]? {
        return ["CheckoutFinished"]
    }

    func finishCheckout() -> ((PXResult?) -> Void)? {
        let navController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        navController.setNavigationBarHidden(true, animated: false)
        checkoutResolver(true)
        return nil
    }

    func cancelCheckout() -> (() -> Void)? {
        let navController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        navController.setNavigationBarHidden(true, animated: false)
        checkoutRejecter("canceled", "checkout canceled", nil)
        return nil
    }

    func changePaymentMethodTapped() -> (() -> Void)? {
        return { () in
            print("px - changePaymentMethodTapped")
        }
    }
}
