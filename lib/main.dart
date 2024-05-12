import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:relaxio/firebase_options.dart';
import 'package:relaxio/pages/ActivityPhase/Profile/Profile.dart';
import 'package:relaxio/pages/ActivityPhase/articles/article.dart';
import 'package:relaxio/pages/ActivityPhase/articles/article_list.dart';
import 'package:relaxio/pages/ActivityPhase/breathing/breath.dart';
import 'package:relaxio/pages/ActivityPhase/chhatboat/chatboat.dart';
import 'package:relaxio/pages/ActivityPhase/footsteps/footsteps.dart';
import 'package:relaxio/pages/ActivityPhase/health/health.dart';
import 'package:relaxio/pages/ActivityPhase/journal/journal.dart';
import 'package:relaxio/pages/ActivityPhase/log_phases/log_screen_1.dart';
import 'package:relaxio/pages/ActivityPhase/log_phases/log_screen_2.dart';
import 'package:relaxio/pages/ActivityPhase/log_phases/log_successfully.dart';
import 'package:relaxio/pages/ActivityPhase/meditation/meditation.dart';
import 'package:relaxio/pages/ActivityPhase/music/music.dart';
import 'package:relaxio/pages/ActivityPhase/music/musiclist.dart';
import 'package:relaxio/pages/ActivityPhase/stress_area/stress_relation_area.dart';
import 'package:relaxio/pages/ActivityPhase/video/video.dart';
import 'package:relaxio/pages/ActivityPhase/video/videolist.dart';
import 'package:relaxio/pages/home/MyHomePage.dart';
import 'package:relaxio/pages/loginPhase/forgotpass.dart';
import 'package:relaxio/pages/loginPhase/login.dart';
import 'package:relaxio/pages/loginPhase/signup.dart';
import 'package:relaxio/pages/loginPhase/user.dart';
import 'package:relaxio/pages/splash_services/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize the binding

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      tools: [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return GetMaterialApp(
      //theme
      theme: ThemeData(primaryColor: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      getPages: [
        // GetPage(name: '/', page: () => Home()),
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/LogMove', page: () => Login()),
        GetPage(name: '/Profile', page: () => Profile()),
        GetPage(name: '/SignupScreen', page: () => SignUp()),
        GetPage(name: '/ForgetPass', page: () => ForgotPassword()),
        GetPage(name: '/Users', page: () => Users()),
        GetPage(name: '/Home', page: () => MyHomePage()),
        GetPage(name: '/MusicList', page: () => MusicList()),
        GetPage(name: '/Music', page: () => Music()),
        GetPage(name: '/Health', page: () => Health()),
        GetPage(name: '/Ai_chat', page: () => Ai_chat()),
        GetPage(name: '/Breathing', page: () => Breathing()),
        GetPage(name: '/ArticleList', page: () => ArticleList()),
        GetPage(name: '/Article', page: () => Article()),
        GetPage(name: '/FootStep', page: () => footsteps()),
        GetPage(name: '/Journal', page: () => JournalHome()),
        GetPage(name: '/VideoList', page: () => VideoList()),
        GetPage(name: '/Video', page: () => Video()),
        GetPage(name: '/LogScreen1', page: () => LogScreen()),
        GetPage(name: '/LogScreen2', page: () => LogScreen2()),
        GetPage(name: '/logSuccessfully', page: () => LogSuccessfully()),
        GetPage(name: '/Stress_Area', page: () => Stress_Area()),
        //GetPage(name: '/daily_task', page: () => Habit_Home()),
        GetPage(name: '/Meditation', page: () => MeditationPage()),

        // GetPage(
        //     name: '/Stress_relation_area', page: () => Stress_relation_area()),

        // home: const ActivityHome(),
        // home: const MusicList(),
      ],
    );
  }
}
