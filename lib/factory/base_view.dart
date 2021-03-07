import 'package:flutter/material.dart';

import 'base_view_state.dart';

abstract class BaseView<T extends BaseViewState> {
  T state;

  @protected
  @mustCallSuper
  BaseView() {
    state = initializeState();
    initialise();
  }

  initialise() {}

  T initializeState();
}
