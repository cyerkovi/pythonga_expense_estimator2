import '../constants/number_constants.dart';

// double roundDouble(double value, int places) {
//  double base = 10.0;
//  num mod = pow(base, places);
//  return ((value * mod).round().toDouble()/mod);
// }

//TODO refactor the following using the second following

double monetaryAmountRounded(double value) {
  // return roundDouble(value, kCurrencyPrecision);
  return double.parse((value.toStringAsFixed(kCurrencyPrecision)));
}

String monetaryAmountRoundedToCurrencyString(double value) {
  return value.toStringAsFixed(kCurrencyPrecision);
}
