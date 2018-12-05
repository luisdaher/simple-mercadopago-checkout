
package com.cavylabs.simplemercadopagocheckout;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.BaseActivityEventListener;
import com.mercadopago.android.px.core.MercadoPagoCheckout;

public class RNSimpleMercadopagoCheckoutModule extends ReactContextBaseJavaModule {

    private Promise mPickerPromise;

    private final ActivityEventListener mActivityEventListener = new BaseActivityEventListener() {
        @Override
        public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent intent) {
            if (requestCode == MERCADOPAGO_REQUEST) {
                if (mPickerPromise != null) {
                    if (resultCode != PAYMENT_SUCCESS_CODE) {
                        mPickerPromise.reject(E_PAYMENT_CANCELLED, "Payment Canceled");
                    } else {
                        mPickerPromise.resolve(true);
                    }

                    mPickerPromise = null;
                }
            }
        }
    };



    public RNSimpleMercadopagoCheckoutModule(ReactApplicationContext reactContext) {
        super(reactContext);
        reactContext.addActivityEventListener(mActivityEventListener);
    }

    @Override
    public String getName() {
        return "RNSimpleMercadopagoCheckout";
    }

    private static final int PAYMENT_SUCCESS_CODE = 7;
    private static final String E_ACTIVITY_DOES_NOT_EXIST = "E_ACTIVITY_DOES_NOT_EXIST";
    private static final int MERCADOPAGO_REQUEST = 411318;
    private static final String E_PAYMENT_CANCELLED = "E_PAYMENT_CANCELLED";

    // @objc func startCheckout(_ publicKey: String, prefId: String , resolver resolve:RCTPromiseResolveBlock,rejecter reject:RCTPromiseRejectBlock) -> Void {
    @ReactMethod
    public void startCheckout(String publicKey, String prefId, final Promise promise) {

        final MercadoPagoCheckout checkout = new MercadoPagoCheckout.Builder(publicKey, prefId)
                .build();


        Activity currentActivity = getCurrentActivity();

        if (currentActivity == null) {
            promise.reject(E_ACTIVITY_DOES_NOT_EXIST, "Activity doesn't exist");
            return;
        }

        // Store the promise to resolve/reject when picker returns data
        mPickerPromise = promise;

        try {
            checkout.startPayment(currentActivity, MERCADOPAGO_REQUEST);
            // mPickerPromise.resolve(true);
        } catch (Exception e) {
            mPickerPromise.reject(e);
        }

    }
}
