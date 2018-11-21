
package com.cavylabs.simplemercadopagocheckout;

import android.app.Activity;
import android.content.Intent;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.mercadopago.android.px.core.MercadoPagoCheckout;
import com.mercadopago.android.px.core.MercadoPagoCheckout.Builder;

public class RNSimpleMercadopagoCheckoutModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

  public RNSimpleMercadopagoCheckoutModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "RNSimpleMercadopagoCheckout";
  }

  private static final int MERCADOPAGO_REQUEST = 411318;

  // @objc func startCheckout(_ publicKey: String, prefId: String , resolver resolve:RCTPromiseResolveBlock,rejecter reject:RCTPromiseRejectBlock) -> Void {
  @ReactMethod
  public void startCheckout(String publicKey, String prefId, final Promise promise) {

      final MercadoPagoCheckout checkout = new MercadoPagoCheckout.Builder(publicKey, prefId)
              .build();

      Builder builder = new MercadoPagoCheckout.Builder(publicKey, prefId);

      Activity currentActivity = getCurrentActivity();

      if (currentActivity == null) {
          promise.reject("Activity doesn't exist");
          return;
      }

      // Store the promise to resolve/reject when picker returns data
      Promise mPickerPromise = promise;

      try {
          checkout.startPayment(currentActivity.getApplicationContext(), MERCADOPAGO_REQUEST);
          mPickerPromise.resolve(true);
      } catch (Exception e) {
          mPickerPromise.reject(e);
      }

  }
}