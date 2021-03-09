import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ig_analytics_dashboard/factory/base_view.dart';
import 'package:ig_analytics_dashboard/factory/base_view_state.dart';
import 'package:ig_analytics_dashboard/models/other_user_details.dart';
import 'package:ig_analytics_dashboard/models/user_details.dart';
import 'package:ig_analytics_dashboard/responses/other_user_data.response.dart';
import 'package:ig_analytics_dashboard/responses/user_data_response.dart';
import 'package:ig_analytics_dashboard/utils/constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ig_analytics_dashboard/utils/string_helper.dart';

class IgDashBoardView extends BaseView<IgDashBoardViewState> {
  @override
  initializeState() {
    return IgDashBoardViewState();
  }

  void getUserData(String userId) {
    var url = '${StringConstants.LAMBDA_ENDPOINT}/userDetails?userId=$userId';
    Uri uri = Uri.parse(url);
    print(uri);
    http.get(uri).then((response) {
      print(response.statusCode);
      print(response.body);
      UserDetails _userDetails =
          getUserDataResponseFromJson(utf8.decode(response.bodyBytes)).mapToUserDetails();
      state._userDetails.add(_userDetails);
    });
  }

  getDataForUserName(String userId) {
    if(!state.textController.value.text.isValid){
      Fluttertoast.showToast(
          msg: "User name can't be empty.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else{
      var url = '${StringConstants.LAMBDA_ENDPOINT}/otherUserDetails?username=${state.textController.value.text}&instaId=${state._userDetails.value.instgramBusinessAccountId}&userId=$userId';
      Uri uri = Uri.parse(url);
      print(uri);
      http.get(uri).then((response) {
        print(response.statusCode);
        print(response.body);
        OtherUserDetails _otherUserDetails =
        getOtherUserDataResponseFromJson(utf8.decode(response.bodyBytes)).mapToOtherUserDetails();
        state._otherUserDetails.add(_otherUserDetails);
        if(_otherUserDetails == null){
          Fluttertoast.showToast(
              msg: "User name invalid or private account.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      });
    }
  }
}

class IgDashBoardViewState extends BaseViewState {
  BehaviorSubject<UserDetails> _userDetails = BehaviorSubject();
  BehaviorSubject<OtherUserDetails> _otherUserDetails = BehaviorSubject();

  TextEditingController textController;

  Stream<UserDetails> get userDetails => _userDetails;
  Stream<OtherUserDetails> get otherUserDetails => _otherUserDetails;

  TabController tabController;

  @override
  dispose() {
    _userDetails.close();
    _otherUserDetails.close();
  }
}
