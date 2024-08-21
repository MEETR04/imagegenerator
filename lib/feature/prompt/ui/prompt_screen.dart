import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagegenerator/feature/prompt/prompt_bloc.dart';

class PromptScreen extends StatefulWidget {
  PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  TextEditingController _controller = TextEditingController();

  final PromptBloc promptBloc = PromptBloc();

  @override
  void initState() {
    // TODO: implement initState
    promptBloc.add(PromptInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Generator with AI"),
        centerTitle: true,
      ),
      body: BlocConsumer<PromptBloc, PromptState>(
        bloc: promptBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PromptGeneratingImageLoadState:
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              );
            case PromptGeneratingImageErrorState:
              return Center(
                child: Text("Something went Wrong"),
              );
            case PromptGeneratingImageSuccessState:
              final successState = state as PromptGeneratingImageSuccessState;
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(
                                  successState.uint8list as Uint8List))),
                    )),
                    Container(
                      height: 240,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter your Prompt",
                            style: TextStyle(
                                fontSize: 25,
                                letterSpacing: 1.1,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextField(
                            controller: _controller,
                            cursorColor: Colors.deepPurple,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.deepPurple)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.deepPurple))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: SizedBox(
                              height: 60,
                              width: double.maxFinite,
                              child: InkWell(
                                onTap: (){
                                  print("button pressed");
                                  if (_controller.text.isNotEmpty) {
                                    promptBloc.add(PromptEnteredEvent(
                                        prompt: _controller.text));
                                  }
                                },
                                child: Container(
                                  width: 80,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.deepPurple
                                  ),
                                  child: Center(child: Text("Generate",style: TextStyle(fontSize: 30),)),
                                ),
                              ),
                              // child: ElevatedButton.icon(
                              //   onPressed: () {
                              //     print("button pressed");
                              //     if (_controller.text.isEmpty) {
                              //       promptBloc.add(PromptEnteredEvent(
                              //           prompt: _controller.text));
                              //     }
                              //   },
                              //   label: Text(
                              //     "Generate",
                              //     style: TextStyle(fontSize: 20),
                              //   ),
                              //   icon: Icon(Icons.generating_tokens),
                              // ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
