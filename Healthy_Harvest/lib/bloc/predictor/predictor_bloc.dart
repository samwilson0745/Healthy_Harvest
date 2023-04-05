import 'package:flutter_bloc/flutter_bloc.dart';
import 'predictor_events.dart';
import 'predictor_states.dart';
import 'package:healthy_harvest/store/predictor/predictor_repo.dart';
import 'package:healthy_harvest/models/predictor_model.dart';

class PredictorBloc extends Bloc<PredictorEvent,PredictorState>{
  final predictor_repo repo;
  PredictorBloc({required this.repo}):super(PredictorInitialised()){
    on<PredictButtonPressed>((event,emit)async{
      emit(PredictorLoading());
      try{
        Predictor prediction = await repo.diagnose(event.path);
        emit(PredictorCompleted(prediction: prediction));
      }catch(e){
        print(e);
        emit(PredictorError(error:"Something Went Wrong"));
      }
    });
  }

}