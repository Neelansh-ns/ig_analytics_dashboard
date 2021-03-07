import 'package:rxdart/rxdart.dart';

abstract class BaseViewState {
  List<Subject> disposables = List();

  dispose() {
    disposables.forEach((observable) {
      observable.close();
    });
    disposables.clear();
  }

  ///adds the Subjects to disposable array to dispose
  addToDispose(List<Subject> subjects) {
    disposables.addAll(subjects);
  }
}
