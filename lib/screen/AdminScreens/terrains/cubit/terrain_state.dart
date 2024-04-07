part of 'terrain_cubit.dart';

@immutable
abstract class TerrainState {}

class TerrainInitial extends TerrainState {}

final class ErrorTerrainsState extends TerrainState {
  final ErrorModel errorModel;

  ErrorTerrainsState({required this.errorModel});
}
//?---------------------------------------- TerrainHomeScreen-----------------------------------------------------------------

class GetMyTerrainsLoading extends TerrainState {}

class GetMyTerrainsStateGood extends TerrainState {}

class GetMyTerrainsStateBad extends TerrainState {}

//? -----------------------------------------Details.dart------------------------------------------
class TerrainSlideChanged extends TerrainState {}

class TerrainViewToggled extends TerrainState {}

class TerrainDateChangedState extends TerrainState {}

// ?-----------------------------------------Reserve.dart------------------------------------------
class LoadinCheckUserByIdState extends TerrainState {}

class CheckUserByIdStateGood extends TerrainState {
  final DataUserModel dataUserModel;

  CheckUserByIdStateGood({required this.dataUserModel});
}

class CheckUserByIdStateBad extends TerrainState {}

//? ------------------------------Create_terrain.dart-------------------------------------------------
class RemoveNonReservableTimeBlockState extends TerrainState {}

class EditingNonReservableTimeBlock extends TerrainState {
  final int? index;

  EditingNonReservableTimeBlock({required this.index});
}

class AddNonReservableTimeBlockState extends TerrainState {}

class DublicatedAddNonReservableTimeBlockState extends TerrainState {}

class SelectedDayChangedState extends TerrainState {
  final String? selctedDay;

  SelectedDayChangedState({required this.selctedDay});
}

final class ErrorState extends TerrainState {
  final ErrorModel errorModel;

  ErrorState({required this.errorModel});
}
