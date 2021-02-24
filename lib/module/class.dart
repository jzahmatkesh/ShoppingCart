abstract class BlocEvent{}
abstract class BlocState {}

class LoadingState extends BlocState{}
class FailedToLoadState extends BlocState {
  Exception error;
  FailedToLoadState({this.error});
}

