import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/models/result.dart';
import '../../../../../../core/utils/status.dart';
import '../../../../problems/data/models/addresses/address_response.dart';
import '../../../../problems/data/models/cities/cities_model.dart';
import '../../../data/repo/address_repo.dart';

part 'address_state.dart';

@injectable
class AddressCubit extends Cubit<AddressState> {
  final AddressRepo _repo;

  AddressCubit(this._repo) : super(const AddressState());

  Future<void> getAddressById(int id) async {
    if (id <= 0) return;

    emit(state.copyWith(addressState: Status.loading));

    final result = await _repo.getAddressById(id);

    switch (result) {
      case ApiSuccessResult<AddressResponse>():
        emit(
          state.copyWith(
            address: result.data,
            addressState: Status.success,
          ),
        );
      case ApiErrorResult<AddressResponse>():
        emit(
          state.copyWith(
            addressError: result.failures.toString(),
            addressState: Status.error,
          ),
        );
    }
  }

  Future<void> getCities() async {
    emit(state.copyWith(addressState: Status.loading));

    final result = await _repo.getCities();

    switch (result) {
      case ApiSuccessResult<List<CitiesModel>>():
      // You might want to handle cities differently in state
      // For now, we'll just indicate success
        emit(
          state.copyWith(
            addressState: Status.success,
          ),
        );
      case ApiErrorResult<List<CitiesModel>>():
        emit(
          state.copyWith(
            addressError: result.failures.toString(),
            addressState: Status.error,
          ),
        );
    }
  }
}