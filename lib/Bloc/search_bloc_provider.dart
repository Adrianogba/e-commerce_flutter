import 'package:flutter/material.dart';
import 'package:fairfruit/Bloc/search_bloc.dart';

class SearchProvider extends InheritedWidget {
  final SearchBloc searchBloc;
  final Widget child;

  SearchProvider({this.searchBloc, this.child}) : super(child: child);

  static SearchProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(SearchProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
