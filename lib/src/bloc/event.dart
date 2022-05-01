part of 'bloc.dart';

abstract class EventS extends Equatable {
  const EventS();
}

class InitialEvent extends EventS {
  @override
  List<Object> get props => [];
}

class LoadDataEvent extends EventS {
  LoadDataEvent();
  @override
  List<Object> get props => [];
}
