import 'package:cleannewsapp/domain/entities/news_entity.dart';
import 'package:cleannewsapp/presentation/pages/home/home_page.dart';
import 'package:cleannewsapp/presentation/pages/home/home_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_page_test.mocks.dart';

@GenerateMocks([HomePresenter])

void main() {
  late HomePresenter homePresenter;
  late MaterialApp homePage;

  void _mockObservables() {
    when(homePresenter.isLoading).thenReturn(false);
    when(homePresenter.internetError).thenReturn(false);
    when(homePresenter.unexpectedError).thenReturn(false);
    when(homePresenter.newsList).thenReturn(mobx.ObservableList());
    when(homePresenter.getNewsByCountry()).thenAnswer((_) async => <NewsEntity>[]);
  }

  setUp(() {
     homePresenter = MockHomePresenter();
     homePage = MaterialApp(home: HomePage(presenter: homePresenter));
     _mockObservables();
  });

  testWidgets('Should start with a loading indicator', (tester) async {
    when(homePresenter.isLoading).thenReturn(true);
    await tester.pumpWidget(homePage);

    expect(find.byKey(const Key("loading_key")), findsOneWidget);
  });

  testWidgets('Should call controller.getNewsByCountry when the page is started', (tester) async {
    await tester.pumpWidget(homePage);

    verify(homePresenter.getNewsByCountry()).called(1);
  });

  testWidgets('Should present only the list of news after a successfull request', (tester) async {
    await tester.pumpWidget(homePage);

    expect(find.byKey(const Key("loading_key")), findsNothing);
    expect(find.byKey(const Key("internet_error")), findsNothing);
    expect(find.byKey(const Key("unexpected_error")), findsNothing);
    expect(find.byKey(const Key("news_list_key")), findsOneWidget);
  });

  testWidgets('Should present only InternetError after a request with no internet connection', (tester) async {
    when(homePresenter.internetError).thenReturn(true);
    await tester.pumpWidget(homePage);

    expect(find.byKey(const Key("loading_key")), findsNothing);
    expect(find.byKey(const Key("news_list_key")), findsNothing);
    expect(find.byKey(const Key("unexpected_error")), findsNothing);
    expect(find.byKey(const Key("internet_error")), findsOneWidget);
  });

  testWidgets('Should call retry function when retry button is tapped if InternetError is being presented', (tester) async {
    when(homePresenter.internetError).thenReturn(true);
    await tester.pumpWidget(homePage);

    expect(find.byKey(const Key("retry_button")), findsOneWidget);

    tester.tap(find.byKey(const Key("retry_button")));
    verify(homePresenter.getNewsByCountry());
  });

  testWidgets('Should present only UnexpectedError after a failed request', (tester) async {
    when(homePresenter.unexpectedError).thenReturn(true);
    await tester.pumpWidget(homePage);

    expect(find.byKey(const Key("loading_key")), findsNothing);
    expect(find.byKey(const Key("news_list_key")), findsNothing);
    expect(find.byKey(const Key("internet_error")), findsNothing);
    expect(find.byKey(const Key("unexpected_error")), findsOneWidget);
  });
}