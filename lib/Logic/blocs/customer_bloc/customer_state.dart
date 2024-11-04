part of 'customer_bloc.dart';

enum CustomerStatus { success, loading, failure }

class CustomerState extends Equatable {
  final CustomerStatus status;
  final List<Customer>? customers;

  const CustomerState._({this.status = CustomerStatus.loading, this.customers,});

  /// No information about [CustomerStatus].
  const CustomerState.loading() : this._();

  /// User status is [success].
  const CustomerState.success(List<Customer>? customers)
      : this._(
          status: CustomerStatus.success,
          customers: customers,
        );

  /// User status is [failure].
  const CustomerState.failure() : this._(status: CustomerStatus.failure);

  @override
  List<Object> get props => [status];
}
