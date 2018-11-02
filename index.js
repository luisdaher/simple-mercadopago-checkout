
import { NativeModules } from 'react-native'

const { RNSimpleMercadopagoCheckout } = NativeModules

export default RNSimpleMercadopagoCheckout

export function startCheckout (publicKey, checkoutPreferenceId) {
  console.log('nativemodules')
  console.log(NativeModules.RNSimpleMercadopagoCheckout)
  if (!publicKey) throw 'publicKey required to start MercadoPago checkout'
  if (!checkoutPreferenceId) throw 'checkoutPreferenceId required to start MercadoPago checkout'

  return RNSimpleMercadopagoCheckout.startCheckout(publicKey, checkoutPreferenceId)

}
