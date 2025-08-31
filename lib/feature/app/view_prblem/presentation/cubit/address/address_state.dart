part of 'address_cubit.dart';

// address_state.dart
class AddressState {
  final Status addressState;
  final String? addressError;
  final AddressResponse? address;

  const AddressState({
    this.addressState = Status.initial,
    this.addressError,
    this.address,
  });

  AddressState copyWith({
    Status? addressState,
    String? addressError,
    AddressResponse? address,
  }) {
    return AddressState(
      addressState: addressState ?? this.addressState,
      addressError: addressError ?? this.addressError,
      address: address ?? this.address,
    );
  }
}
