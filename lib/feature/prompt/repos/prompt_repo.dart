import 'dart:developer';
import 'package:dio/dio.dart';
import 'dart:typed_data';

class PromptRepo {
  static Future<Uint8List?> generateimage(String prompt) async {
    try {
      String url = "https://api.vyro.ai/v1/imagine/api/generations";
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer 	vk-2YiYlCwUnFVdBOdclfpDCcvH22l5RkzDhxF5nRB3sKVNMzg'
      };
      Map<String, dynamic> payload = {
        'prompt': prompt,
        'style_id': '122',
        'aspect_ratio': '1:1',
        'cfg': '3',
        'seed': '7',
        'steps': '30',
        'high_res_results': '1'
      };

      FormData formData = FormData.fromMap(payload);

      Dio dio = Dio();
      dio.options = BaseOptions(
        headers: headers,
        responseType: ResponseType.bytes,
      );

      print("Sending request to $url with payload: $payload");
      final response = await dio.post(url, data: formData);

      log("Response status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        log(response.data.runtimeType.toString() );
        log(response.data.toString());
        Uint8List uint8list = Uint8List.fromList(response.data);
        return uint8list;
      } else {
        print("Failed to generate image. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error generating image: $e");
      return null;
    }
  }
}
