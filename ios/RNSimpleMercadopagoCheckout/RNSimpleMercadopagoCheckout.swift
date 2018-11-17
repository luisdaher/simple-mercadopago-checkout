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
        let builder = MercadoPagoCheckoutBuilder.init(publicKey: publicKey, preferenceId: prefId)
        let navController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        navController.setToolbarHidden(false, animated: true)
        navController.setNavigationBarHidden(false, animated: true)
        //TODO: Voltar com true assim que sair das telas do MercadoPago
        builder.setLanguage("pt")
        MercadoPagoCheckout.init(builder: MercadoPagoCheckoutBuilder.init(publicKey: publicKey, preferenceId: prefId)).start(navigationController: UIApplication.shared.keyWindow?.rootViewController as! UINavigationController)
        resolve(true);
    }

}

// MARK: Optional Lifecycle protocol implementation example.
extension RNSimpleMercadopagoCheckout: PXLifeCycleProtocol {
    func finishCheckout() -> ((PXResult?) -> Void)? {
        let navController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        navController.setToolbarHidden(true, animated: true)
        navController.setNavigationBarHidden(true, animated: true)
        return nil
    }

    func cancelCheckout() -> (() -> Void)? {
        let navController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        navController.setToolbarHidden(true, animated: true)
        navController.setNavigationBarHidden(true, animated: true)
        return nil
    }

    func changePaymentMethodTapped() -> (() -> Void)? {
        return { () in
            print("px - changePaymentMethodTapped")
        }
    }
}
