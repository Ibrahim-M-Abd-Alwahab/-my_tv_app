import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_tv_app/Modules/Main/MobileData/VideoLibrary/all_videu_list.dart';
import 'package:my_tv_app/Modules/Main/MobileData/mobile_data_show.dart';
import 'package:my_tv_app/helpers/sp_helper.dart';
import 'package:my_tv_app/provider/account_provider.dart';
import 'package:sizer/sizer.dart';
import 'Modules/Main/All/Settings/add_cirtification_file.dart';
import 'Modules/Main/All/Settings/geniral_settings.dart';
import 'Modules/Main/All/Settings/settings_screen.dart';
import 'Modules/Main/All/Settings/switch_device_mode.dart';
import 'Modules/Main/All/Settings/time_style.dart';
import 'Modules/Main/All/Settings/tv_program_guide.dart';
import 'Modules/Main/All/multyScreen/all_channels.dart';
import 'Modules/Main/All/multyScreen/channels_multy_screen_list.dart';
import 'Modules/Main/All/multyScreen/favoret.dart';
import 'Modules/Main/All/multyScreen/multy_screen.dart';
import 'Modules/Main/LinkOrChannelsFolder/link_or_channel_folder.dart';
import 'Modules/Main/MobileData/MusicLibrary/all_music_list.dart';
import 'Modules/Main/MobileData/XtreamCode/vpn/vpn_sertification.dart';
import 'Modules/Main/MobileData/XtreamCode/xtream_code_login_screen.dart';
import 'Modules/Main/UsersList/Users_list.dart';
import 'Modules/Main/login_type.dart';
import 'Modules/Splash/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

// This is the type used by the popup menu below.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final accountProvider = AccountProvider();

  await accountProvider.getIPAddress().then((ipAddress) {
    if (kDebugMode) {
      print('IP Address: $ipAddress');
    }
  }).catchError((error) {
    if (kDebugMode) {
      print('Failed to get IP address: $error');
    }
  });
  await SpHelper.initSharedPreferences();
  Intl.defaultLocale = 'en_US';
  await initializeDateFormatting('en_US', null);
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    //   SystemUiOverlay.bottom,
    //   SystemUiOverlay.top,
    // ]);
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue, canvasColor: const Color(0xfffffef4)),
        home: const SplashScreen(),
        routes: {
          SplashScreen.roudName: (cox) => const SplashScreen(),
          LoginTypeScreen.roudName: (cox) => const LoginTypeScreen(),
          MobileDataShow.roudName: (cox) => const MobileDataShow(),
          AllVideoScreen.roudName: (cox) => const AllVideoScreen(),
          AllMusicScreen.roudName: (cox) => const AllMusicScreen(),
          LinkOrChannelsFolder.roudName: (cox) => const LinkOrChannelsFolder(),
          UsersListScreen.roudName: (cox) => const UsersListScreen(),
          SettingsScreen.roudName: (cox) => const SettingsScreen(),
          XtreamCodeLoginScreen.roudName: (cox) =>
              const XtreamCodeLoginScreen(),
          VpnCertificationScreen.roudName: (cox) =>
              const VpnCertificationScreen(),
          MultyScreen.roudName: (cox) => const MultyScreen(),
          ChannelsMultyScreen.roudName: (cox) => const ChannelsMultyScreen(),
          FavorateChannelScreen.roudName: (cox) =>
              const FavorateChannelScreen(),
          AllChannelScreen.roudName: (cox) => const AllChannelScreen(),
          GeneralSettingScreen.roudName: (cox) => const GeneralSettingScreen(),
          AddCertificationFile.roudName: (cox) => const AddCertificationFile(),
          SwitchDeviceModeScreen.roudName: (cox) =>
              const SwitchDeviceModeScreen(),
          TimeStyleScreen.roudName: (cox) => const TimeStyleScreen(),
          TvProgramGuideScreen.roudName: (cox) => const TvProgramGuideScreen(),
        },
      );
    });
  }
}
