@JS()
library stripe;

import 'package:flutter/material.dart';
import 'package:eventus/assets/configurations/striipe_constants.dart';
import 'package:js/js.dart';

void redirectToCheckout(
    BuildContext _, String priceId, String eventName) async {
  final stripe = Stripe(apiKey);
  stripe.redirectToCheckout(CheckoutOptions(
    lineItems: [
      LineItem(price: priceId, quantity: 1),
    ],
    mode: 'payment',
    successUrl:
        'https://clever-abbey-384113.web.app/#/success?session_id={CHECKOUT_SESSION_ID}&event_name=$eventName',
    cancelUrl: 'https://clever-abbey-384113.web.app/#/',
  ));
}

@JS()
class Stripe {
  external Stripe(String key);

  external redirectToCheckout(CheckoutOptions options);
}

@JS()
@anonymous
class CheckoutOptions {
  external List<LineItem> get lineItems;

  external String get mode;

  external String get successUrl;

  external String get cancelUrl;

  external factory CheckoutOptions({
    List<LineItem> lineItems,
    String mode,
    String successUrl,
    String cancelUrl,
    String sessionId,
  });
}

@JS()
@anonymous
class LineItem {
  external String get price;

  external int get quantity;

  external factory LineItem({String price, int quantity});
}
