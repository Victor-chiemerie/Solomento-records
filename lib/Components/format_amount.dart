import 'package:intl/intl.dart';

String formatAmount(int amount) {
  // convert String value to double value
  final doubleAmount = double.parse(amount.toString());
  // Format the amount with commas for thousands and two decimal places
  final formattedAmount = NumberFormat('#,##0', 'en_US').format(doubleAmount);
  // NumberFormat('#,##0.00', 'en_US').format(doubleAmount);

  return formattedAmount;
}
