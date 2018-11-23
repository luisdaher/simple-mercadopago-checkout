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
    @objc static func requiresMainQueueSetup() -> Bool {
        return false
    }

    @objc func startCheckout(_ publicKey: String, prefId: String , resolver resolve:RCTPromiseResolveBlock,rejecter reject:RCTPromiseRejectBlock) -> Void {
        let builder = MercadoPagoCheckoutBuilder.init(publicKey: publicKey, preferenceId: prefId)
        let navController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        navController.setNavigationBarHidden(false, animated: true)

        builder.setLanguage("pt-BR")
        builder.setColor(checkoutColor: UIColor.green)
        MercadoPagoCheckout.init(builder: MercadoPagoCheckoutBuilder.init(publicKey: publicKey, preferenceId: prefId)).start(navigationController: UIApplication.shared.keyWindow?.rootViewController as! UINavigationController, lifeCycleProtocol: self)
        resolve(true);
    }

}

// MARK: Optional Lifecycle protocol implementation example.
extension RNSimpleMercadopagoCheckout: PXLifeCycleProtocol {
    func finishCheckout() -> ((PXResult?) -> Void)? {
        let navController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        navController.setNavigationBarHidden(true, animated: true)
        return nil
    }

    func cancelCheckout() -> (() -> Void)? {
        let navController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        navController.setNavigationBarHidden(true, animated: false)
        return nil
    }

    func changePaymentMethodTapped() -> (() -> Void)? {
        return { () in
            print("px - changePaymentMethodTapped")
        }
    }
}
