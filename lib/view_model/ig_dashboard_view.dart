import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ig_analytics_dashboard/factory/base_view.dart';
import 'package:ig_analytics_dashboard/factory/base_view_state.dart';
import 'package:ig_analytics_dashboard/models/user_details.dart';
import 'package:ig_analytics_dashboard/responses/user_data_response.dart';
import 'package:ig_analytics_dashboard/utils/constants.dart';
import 'package:rxdart/rxdart.dart';

class IgDashBoardView extends BaseView<IgDashBoardViewState> {
  @override
  initializeState() {
    return IgDashBoardViewState();
  }

  void getUserData(String userId) {
    var url = '${StringConstants.LAMBDA_ENDPOINT}//userDetails?userId=$userId';
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
}

class IgDashBoardViewState extends BaseViewState {
  BehaviorSubject<UserDetails> _userDetails = BehaviorSubject();

  Stream<UserDetails> get userDetails => _userDetails;

  @override
  dispose() {
    _userDetails.close();
  }
}
