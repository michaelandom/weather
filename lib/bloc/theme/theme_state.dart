part of 'theme_bloc.dart';

@immutable
class ThemeState extends Equatable {
  final ThemeData themeData;
  ThemeState({@required this.themeData});

  @override
  // TODO: implement props
  List<Object> get props => [themeData];
}
