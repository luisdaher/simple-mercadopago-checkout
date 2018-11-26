
import { NativeModules } from 'react-native'
import axios from 'axios'

const { RNSimpleMercadopagoCheckout } = NativeModules

export default RNSimpleMercadopagoCheckout
// TODO: passar payer.address.zip_code , payer.address.street_name , payer.address.street_number
export function startCheckout (clientId, clientSecret, publicKey, payerData, items = []) {
  console.log('nativemodules')
  console.log(NativeModules.RNSimpleMercadopagoCheckout)
  if (!clientId) throw 'clientId required to start MercadoPago checkout'
  if (!clientSecret) throw 'clientSecret required to start MercadoPago checkout'
  if (!publicKey) throw 'publicKey required to start MercadoPago checkout'

  return axios.post('https://api.mercadopago.com/oauth/token', {
    grant_type: 'client_credentials',
    client_id: clientId,
    client_secret: clientSecret
  }).then(function (response) {
    // handle success
    // console.log(response.data.access_token)
    let accessToken = response.data.access_token

    return axios.post(`https://api.mercadopago.com/checkout/preferences?access_token=${accessToken}`, {
      items: items,
      payer: payerData
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
  })
  .catch(function (error) {
    // handle error
    console.log(error)
    return new Promise((resolve, reject) => reject(error))
  })
}
