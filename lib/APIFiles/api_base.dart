import 'dart:convert';
import 'dart:io';

import 'package:api_integration_sample/APIFiles/custom_exception.dart';
import 'package:api_integration_sample/Models/response_resolver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class ApiBase {
  final String base_url = "reqres.in";
//---------------------------GET---------------------------------------

  Future<ResponseResolver> get(
      BuildContext context,
      String url,
      Function(String) onFail,
      Map<String, String> queryParams,
      Map<String, String> headers,
      bool showError,
      bool showLoading) async {
    if (showLoading) {
//TODO: If you dont want to use EasyLoading then replace your Code here .
      if (!EasyLoading.isShow) {
        EasyLoading.show(status: "");
      }
    }

    var responseJson;

    if (kDebugMode) {
      print("URL ==== ${Uri.https(base_url, url, queryParams)}");
    }
    if (kDebugMode) {
      print("HEADERS ==== $headers");
    }
    try {
      final response = await http.get(Uri.https(base_url, url, queryParams),
          headers: headers);
      responseJson = _responseReturnFail(response, context, onFail, showError);
    } on SocketException {
      if (showLoading) {
//TODO: If you dont want to use EasyLoading then replace your Code here .
        if (EasyLoading.isShow) {
          EasyLoading.dismiss();
        }
      }
//TODO: Here you can Enter code for  your No Internet Management
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (builder) {
//             return NoInternetScreen();
//           }), (route) => false);

      throw FetchDataException("No Internet");
    }
    if (showLoading) {
//TODO: If you dont want to use EasyLoading then replace your Code here .
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    }
    return ResponseResolver.fromJson(responseJson);

    // return responseJson;
  }

//----------------------------PUT-------------------------------------
  Future<ResponseResolver> put(
      BuildContext context,
      String url,
      Function(String) onFail,
      Map<String, String> headers,
      Object body,
      bool showError,
      bool showLoading) async {
    if (showLoading) {
//TODO: If you dont want to use EasyLoading then replace your Code here .
      if (!EasyLoading.isShow) {
        EasyLoading.show(status: "");
      }
    }
    var responseJson;
    try {
      final response = await http.put(Uri.https(base_url, url),
          headers: headers, body: body);
      if (kDebugMode) {
        print("URL ==== ${Uri.https(base_url, url)}");
      }
      responseJson = _responseReturnFail(response, context, onFail, showError);
    } on SocketException {
      if (showLoading) {
//TODO: If you dont want to use EasyLoading then replace your Code here .
        if (EasyLoading.isShow) {
          EasyLoading.dismiss();
        }
      }
//TODO: Here you can Enter code for  your No Internet Management
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (builder) {
//             return NoInternetScreen();
//           }), (route) => false);

      throw FetchDataException("No Internet");
    }
    if (showLoading) {
//TODO: If you dont want to use EasyLoading then replace your Code here .
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    }
    return ResponseResolver.fromJson(responseJson);
  }

//----------------------------POST-------------------------------------
  Future<ResponseResolver> post(
      BuildContext context,
      String url,
      Function(String) onFail,
      Map<String, String> headers,
      Object body,
      bool showError,
      bool showLoading) async {
    if (showLoading) {
//TODO: If you dont want to use EasyLoading then replace your Code here .
      if (!EasyLoading.isShow) {
        EasyLoading.show(status: "");
      }
    }
    var responseJson;
    try {
      final response = await http.post(Uri.https(base_url, url),
          headers: headers, body: jsonEncode(body));
      if (kDebugMode) {
        print("URL ==== ${Uri.https(base_url, url)}");
      }
      if (kDebugMode) {
        print("BODY ==== $body");
      }
      if (kDebugMode) {
        print("HEADERS ==== $headers");
      }
      responseJson = _responseReturnFail(response, context, onFail, showError);
    } on SocketException {
      if (showLoading) {
//TODO: If you dont want to use EasyLoading then replace your Code here .
        if (EasyLoading.isShow) {
          EasyLoading.dismiss();
        }
      }
//TODO: Here you can Enter code for  your No Internet Management
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (builder) {
//             return NoInternetScreen();
//           }), (route) => false);

      throw FetchDataException("No Internet");
    }
    if (showLoading) {
//TODO: If you dont want to use EasyLoading then replace your Code here .
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    }
    return ResponseResolver.fromJson(responseJson);
  }
}

dynamic _responseReturnFail(http.Response response, context,
    Function(String) onFail, bool showErrorPopup) {
  print("Status Code" + response.statusCode.toString());
//TODO: If you dont want to use EasyLoading then replace your Code here .
  if (EasyLoading.isShow) {
    EasyLoading.dismiss();
  }

  switch (response.statusCode) {
    case 200:
      print(response.body);
      var responseJson = json.decode(response.body);

      if (kDebugMode) {
        print("RESPONSE ==== $responseJson");
      }
      return responseJson;
    case 400:

      // MainUtils().showToast(json.decode(response.body));
      // print(response.body);
      var responseJson = json.decode(response.body);
      if (kDebugMode) {
        print("RESPONSE ==== $responseJson");
      }
      ResponseResolver responseResolver =
          ResponseResolver.fromJson(responseJson);

//TODO: If you dont want to use EasyLoading then replace your Code here .
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      if (showErrorPopup) {
//TODO: Add your Error Popup or anything you want to show in case of error here
        print("EEEROR");
        // MainUtils().showToast(responseResolver.message);
      }
      onFail(responseResolver.data.toString());
      throw BadRequestException([responseResolver.message]);
    case 401:
      // MainUtils().showToast('Something went wrong!');
      var responseJson = json.decode(response.body);
      if (kDebugMode) {
        print("RESPONSE ==== $responseJson");
      }
      ResponseResolver responseResolver =
          ResponseResolver.fromJson(responseJson);
//TODO: Manage Session Expire
      //  MainUtils().showToast("Session Expired Please Re-Login");
      //  AuthenticationService().userLogout();

      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (builder) {
      //   return LoginPhone();
      // }), (route) => false);

      onFail(responseResolver.data);
//TODO: If you dont want to use EasyLoading then replace your Code here .
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      throw UnauthorisedException([responseResolver.message]);

    // case 403:
    //   throw UnauthorisedException(response.body.toString());
    // case 500:

    default:
      print(response.body);
//TODO: If you dont want to use EasyLoading then replace your Code here .
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }

      onFail("Something Went Wrong!");
      if (showErrorPopup) {
//TODO: Add your Error Popup or anything you want to show in case of error here
//         MainUtils().showToast("Something Went Wrong!");
      }

      throw FetchDataException("Bad Communication" '${response.statusCode}');
  }
}
