import 'package:equatable/equatable.dart';
import 'package:healthy_harvest/models/predictor_model.dart';

class PredictorState extends Equatable{
  @override
  List<Object> get props=>[];
}
class PredictorInitialised extends PredictorState{

}
class PredictorLoading extends PredictorState{

}
class PredictorCompleted extends PredictorState{
  final Predictor prediction;
  PredictorCompleted({required this.prediction});
  @override
  List<Object> get props =>[prediction];
}
class PredictorError extends PredictorState{
  final String error;
  PredictorError({required this.error});
  @override
  List<Object> get props =>[error];
}