// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_HomeControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$internetErrorAtom = Atom(name: '_HomeControllerBase.internetError');

  @override
  bool get internetError {
    _$internetErrorAtom.reportRead();
    return super.internetError;
  }

  @override
  set internetError(bool value) {
    _$internetErrorAtom.reportWrite(value, super.internetError, () {
      super.internetError = value;
    });
  }

  final _$unexpectedErrorAtom =
      Atom(name: '_HomeControllerBase.unexpectedError');

  @override
  bool get unexpectedError {
    _$unexpectedErrorAtom.reportRead();
    return super.unexpectedError;
  }

  @override
  set unexpectedError(bool value) {
    _$unexpectedErrorAtom.reportWrite(value, super.unexpectedError, () {
      super.unexpectedError = value;
    });
  }

  final _$getNewsByCountryAsyncAction =
      AsyncAction('_HomeControllerBase.getNewsByCountry');

  @override
  Future<void> getNewsByCountry() {
    return _$getNewsByCountryAsyncAction.run(() => super.getNewsByCountry());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
internetError: ${internetError},
unexpectedError: ${unexpectedError}
    ''';
  }
}
