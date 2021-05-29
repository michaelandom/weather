part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChange extends ThemeEvent {
  AppTheme appTheme;
  ThemeChange({@required this.appTheme});

  @override
  // TODO: implement props
  List<Object> get props => [appTheme];
}
