import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:rayahhalekapp/helper/helper.dart';

class ApiRequest {
  static final String url = "https://rayeh-hayatak.com/api/";

  static Future<http.Response> fetchData(String subUrl,
      {bool isRequiredToken = false,String token = ""}) async {
    print(url + subUrl);
    Map headers = Map<String, String>();
    headers["X-localization"] = "ar";
    print(isRequiredToken);
    if (isRequiredToken) {
       headers["api_token"] = token != "" ? token : Helper.token;
    }
    final response = await http.get(url + subUrl, headers: headers);
    print(headers);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else if (response.statusCode == 502) {
      throw Exception("network err");
    } else if (response.statusCode == 401) {
      throw Exception("unAuth");
    } else {
      throw Exception(jsonDecode(response.body)["message"].toString());
    }
  }

  static Future<String> uploadMulitpart(String subUrl, List<File> image,
      List<String> keys, HashMap<String, String> params,
      {bool isRequiredToken = false, String token = ""}) async {
    HashMap<String, String> headers = HashMap<String, String>();
    headers["X-localization"] = "ar";
    if (isRequiredToken) {
      headers["api_token"] = token != "" ? token : Helper.token;
    }
    print(params);
    print(headers);
    final req = http.MultipartRequest("POST", Uri.parse(url + subUrl));
    if (image != null)
      for (int i = 0; i < image.length; i++) {
        req.files.add(
          http.MultipartFile(
              keys[i], image[i].readAsBytes().asStream(), image[i].lengthSync(),
              filename: 'filename.png'),
        );
      }

    req.headers.addAll(headers);
    req.fields.addAll(params);

    var response = await req.send();
    final respStr = await response.stream.bytesToString();

    print(response.statusCode);

    print(respStr);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return respStr;
    } else if (response.statusCode == 502) {
      throw Exception("network err");
    } else {
      throw Exception(subUrl == "register" ||
              subUrl == "update_profile" &&
                  (jsonDecode(respStr)["data"] as List).length > 0
          ? (jsonDecode(respStr)["data"][0].toString())
          : jsonDecode(respStr)["message"].toString());
    }
  }

  static Future<http.Response> postData(
      String subUrl, HashMap<String, dynamic> params,
      {bool isRequiredToken = false, String token = ""}) async {
    print(url + subUrl);
    HashMap<String, String> headers = HashMap<String, String>();
    headers["X-localization"] = "ar";
    if (isRequiredToken) {
      headers["api_token"] = token != "" ? token : Helper.token;
    }
    final response =
        await http.post(url + subUrl, body: params, headers: headers);
    print(response.statusCode);
    print(headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else if (response.statusCode == 502) {
      throw Exception("network err");
    } else {
      throw Exception(subUrl == "update_profile" &&
              (jsonDecode(response.body)["data"] as List).length > 0
          ? (jsonDecode(response.body)["data"][0].toString())
          : jsonDecode(response.body)["message"].toString());
    }
  }
}
