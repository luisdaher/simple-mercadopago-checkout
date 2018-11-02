using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Simple.Mercadopago.Checkout.RNSimpleMercadopagoCheckout
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNSimpleMercadopagoCheckoutModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNSimpleMercadopagoCheckoutModule"/>.
        /// </summary>
        internal RNSimpleMercadopagoCheckoutModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNSimpleMercadopagoCheckout";
            }
        }
    }
}
