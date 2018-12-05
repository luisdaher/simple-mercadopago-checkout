
# react-native-simple-mercadopago-checkout

## Getting started

`$ npm install react-native-simple-mercadopago-checkout --save`

### Mostly automatic installation

`$ react-native link react-native-simple-mercadopago-checkout`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-simple-mercadopago-checkout` and add `RNSimpleMercadopagoCheckout.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNSimpleMercadopagoCheckout.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNSimpleMercadopagoCheckoutPackage;` to the imports at the top of the file
  - Add `new RNSimpleMercadopagoCheckoutPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-simple-mercadopago-checkout'
  	project(':react-native-simple-mercadopago-checkout').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-simple-mercadopago-checkout/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-simple-mercadopago-checkout')
  	```


## Usage
```javascript
import { startCheckout } from 'react-native-simple-mercadopago-checkout';

//refer to https://www.mercadopago.com.br/developers/en/api-docs/basic-checkout/checkout-preferences/ for more detailed info on how to populate the items and payerData
startCheckout(MERCADOPAGO_CLIENT_ID, MERCADOPAGO_CLIENT_SECRET, MERCADOPAGO_TEST_PUBLICKEY, payerData, items)
```

## MercadoPago preference reference
https://www.mercadopago.com.br/developers/en/api-docs/basic-checkout/checkout-preferences/

## Testing

### Credit Cards
(obs.: see https://www.mercadopago.com.br/developers/pt/solutions/payments/basic-checkout/test/test-payments/)

For brazilian cards, use:
- 4235 6477 2802 5682	(Visa)
- 5031 4332 1540 6351	(Master)
- 3753 651535 56885 (Amex)
