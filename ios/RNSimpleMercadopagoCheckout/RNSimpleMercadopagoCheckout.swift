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
    var navigationController:UIViewController!

    @objc override static func requiresMainQueueSetup() -> Bool {
        return false
    }

    @objc func startCheckout(_ publicKey: String, prefId: String , resolver resolve:@escaping RCTPromiseResolveBlock,rejecter reject:@escaping RCTPromiseRejectBlock) -> Void {
        let builder = MercadoPagoCheckoutBuilder.init(publicKey: publicKey, preferenceId: prefId)
        checkoutResolver = resolve
        checkoutRejecter = reject
        self.navigationController = UIApplication.shared.keyWindow?.rootViewController

        builder.setLanguage("pt-BR")
        DispatchQueue.main.async(execute: {
            // creating a dummy controller
            let nav1 = UINavigationController()
            let mainView = UIViewController(nibName: nil, bundle: nil)
            nav1.viewControllers = [mainView]
            UIApplication.shared.keyWindow?.rootViewController = nav1

            let checkout = MercadoPagoCheckout.init(builder: builder)
            checkout.start(navigationController: nav1, lifeCycleProtocol: self)
        })
    }

    func restoreNavigationBarProperties() -> Void {
        UIApplication.shared.keyWindow?.rootViewController = self.navigationController
    }
}

// MARK: Optional Lifecycle protocol implementation example.
extension RNSimpleMercadopagoCheckout: PXLifeCycleProtocol {

    @objc override func supportedEvents() -> [String]? {
        return ["CheckoutFinished"]
    }

    func finishCheckout() -> ((PXResult?) -> Void)? {
        self.restoreNavigationBarProperties()
        checkoutResolver(true)
        return nil
    }

    func cancelCheckout() -> (() -> Void)? {
        self.restoreNavigationBarProperties()
        checkoutRejecter("canceled", "checkout canceled", nil)
        return nil
    }

    func changePaymentMethodTapped() -> (() -> Void)? {
        return { () in
            print("px - changePaymentMethodTapped")
        }
    }
}
