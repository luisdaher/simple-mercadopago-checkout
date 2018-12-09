
import { NativeModules } from 'react-native'
import axios from 'axios'

const { RNSimpleMercadopagoCheckout } = NativeModules

export default RNSimpleMercadopagoCheckout
// TODO: passar payer.address.zip_code , payer.address.street_name , payer.address.street_number
export function startCheckout (accessToken, publicKey, payerData, items = []) {
  console.log('nativemodules')
  console.log(NativeModules.RNSimpleMercadopagoCheckout)
  if (!accessToken) throw 'token required to start MercadoPago checkout'
  if (!publicKey) throw 'publicKey required to start MercadoPago checkout'

  return axios.post(`https://api.mercadopago.com/checkout/preferences?access_token=${accessToken}`, {
    items: items,
    payer: payerData,
    payment_methods: {
      excluded_payment_types: [{id: 'atm'}, {id: 'ticket'}, {id: 'bank_transfer'}]
    }
  }).then(function (res) {
    // handle success
    // console.log(res)
    let checkoutPreferenceId = res.data.id
    return RNSimpleMercadopagoCheckout.startCheckout(publicKey, checkoutPreferenceId)
  })
  .catch(function (error) {
    // handle error
    console.log(error)
    return new Promise((resolve, reject) => reject(error))
  })
}
