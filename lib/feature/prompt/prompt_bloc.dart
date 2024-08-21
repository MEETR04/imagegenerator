
import 'dart:typed_data'; // Import from the correct source

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:imagegenerator/feature/prompt/repos/prompt_repo.dart';
import 'package:meta/meta.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptInitialEvent>((event, emit) async {
      ByteData byteData = await rootBundle.load("assets/file.png");
      Uint8List uint8list = byteData.buffer.asUint8List();
      emit(PromptGeneratingImageSuccessState(uint8list));
    });
    on<PromptEvent>((event, emit) {});
    on<PromptEnteredEvent>((event, emit) async {
      emit(PromptGeneratingImageLoadState());
      Uint8List? bytes = await PromptRepo.generateimage(event.prompt);
      if (bytes != null) {
        emit(PromptGeneratingImageSuccessState(bytes));
      } else {
        emit(PromptGeneratingImageErrorState());
      }
    });
  }
}
