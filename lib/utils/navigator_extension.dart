import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  @optionalTypeArgs
  Future<T?> push<T extends Object?>(Widget page) => Navigator.of(this).push(
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );

  @optionalTypeArgs
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(Widget page,
      {TO? result}) => Navigator.of(this).pushReplacement(
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );

  @optionalTypeArgs
  Future<T?> pushAndRemoveAll<T extends Object?>(Widget page) => Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (Route<dynamic> route) => false,
    );

  @optionalTypeArgs
  Future<T?> pushAndRemoveUntil<T extends Object?>(
      Widget page, RoutePredicate predicate) => Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      predicate,
    );

  @optionalTypeArgs
  Future<bool> maybePop<T extends Object?>([T? result]) async => Navigator.of(this).maybePop(result);

  @optionalTypeArgs
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }

  void popUntil(RoutePredicate predicate) {
    Navigator.of(this).popUntil(predicate);
  }
}
