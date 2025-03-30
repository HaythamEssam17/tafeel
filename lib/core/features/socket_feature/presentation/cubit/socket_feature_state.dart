part of 'socket_feature_cubit.dart';

abstract class SocketFeatureState {}

class SocketFeatureInitial extends SocketFeatureState {}

class SocketFeatureOpenSocketLoading extends SocketFeatureState {}

class SocketFeatureOpenSocketSuccess extends SocketFeatureState {}

class SocketFeatureOpenSocketFailed extends SocketFeatureState {
  final CustomError customError;

  SocketFeatureOpenSocketFailed({required this.customError});
}
