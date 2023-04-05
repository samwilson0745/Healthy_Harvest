import 'package:equatable/equatable.dart';

class PredictorEvent extends Equatable{
  const PredictorEvent();
  @override
  List<Object?> get props => [];
}
class PredictButtonPressed extends PredictorEvent{
  final String path;
  PredictButtonPressed({required this.path}){
    print(this.path);
  }

  @override
  List<Object?> get props => [path];

  @override
  String toString()=>"Image Path is $path";

}