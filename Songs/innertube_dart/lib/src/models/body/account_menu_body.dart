import '../context.dart';

class AccountMenuBody {
  final Context context;
  final String deviceTheme;
  final String userInterfaceTheme;

  const AccountMenuBody({
    required this.context,
    this.deviceTheme = "DEVICE_THEME_SELECTED",
    this.userInterfaceTheme = "USER_INTERFACE_THEME_DARK",
  });

  Map<String, dynamic> toJson() => {
        'context': context.toJson(),
        'deviceTheme': deviceTheme,
        'userInterfaceTheme': userInterfaceTheme,
      };
}
