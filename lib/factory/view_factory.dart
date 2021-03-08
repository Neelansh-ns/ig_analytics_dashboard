import 'package:ig_analytics_dashboard/factory/base_view.dart';
import 'package:ig_analytics_dashboard/view_model/authenticate_view.dart';
import 'package:ig_analytics_dashboard/view_model/ig_dashboard_view.dart';


class ViewFactory {

  static final ViewFactory _instance = ViewFactory._();

  factory ViewFactory() {
    return _instance;
  }

  ViewFactory._();

  final Map<Type, BaseView> _viewMap = Map();

  T get<T>() {
    if (_viewMap.containsKey(T)) {
      return _viewMap[T] as T;
    } else {
      BaseView view = _get<T>();
      _viewMap[T] = view;
//      _viewMap.putIfAbsent(T,()=> view);
      return view as T;
    }
  }

  BaseView _get<T>() {
    switch (T) {
      case AuthenticateView: return AuthenticateView();
      case IgDashBoardView: return IgDashBoardView();
      default:
        return throw Exception("View is not created for $T");
    }
  }

  void clearSession() {
    _viewMap.removeWhere((key, value) {
      switch (key) {
        default:
          return true;
      }
    });
  }
}
