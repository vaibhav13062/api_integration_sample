import 'package:api_integration_sample/APIFiles/api_base.dart';
import 'package:api_integration_sample/Models/response_resolver.dart';
import 'package:flutter/material.dart';

class ApiInterface {
  Map<String, String> basicHeader = {"Content-Type": "application/json"};

  Future<ResponseResolver> getUserDetails(
      BuildContext context, String userId , Function(dynamic) onFail) async {
    return await ApiBase().get(
        context,
        "/User/getUserDetails" //API END PONT
        ,
        onFail // ON FAIL
        ,
        {"userId": userId} //QUERY PARAMETERS
        ,
        basicHeader //HEADERS
        ,
        false //SHOW ERROR FLAG
        ,
        true //SHOW LOADING FLAG
        );
  }

  Future<ResponseResolver> addNewUser(
    BuildContext context,
    String name,
    String email,
    String phone
  , Function(dynamic) onFail
  ) async {
    return await ApiBase().post(
        context,
        "/User/addNewUser" //API END PONT
        ,
        onFail // ON FAIL
        ,
        basicHeader //HEADERS
        ,
        {"name": name, "email": email, "phone": phone}, // BODY
        false //SHOW ERROR FLAG
        ,
        true //SHOW LOADING FLAG
        );
  }
}
