import 'package:app_settings/app_settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gami/Constant/PrefManager.dart';
import 'package:gami/Screens/Loader.dart';
import 'package:gami/Screens/Tabbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gami/Screens/OnboardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gami/Constant/Constant.dart';



/*

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    await Firebase.initializeApp();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: MyAds(),
        home:Tabbar()
    );
  }

}*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    await Firebase.initializeApp();
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotifications =
      FlutterLocalNotificationsPlugin();

  bool isLoggedIn = false;

  @override
  void initState() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@drawable/app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotifications.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    didCheckForNotificationPermission();

    Future.delayed(Duration(seconds: 1), () async {

      try {
        final sharedPref = await SharedPreferences.getInstance();
        final savedMobileNumber = sharedPref.get(kMobileNumber).toString();

        // print('savedMobileNumbersavedMobileNumbersavedMobileNumbersavedMobileNumber');
        // print(strMobileNumber);
        // print(savedMobileNumber);
        // print(savedMobileNumber.isNotEmpty);

        if (savedMobileNumber == 'null' ||
            savedMobileNumber.isEmpty) {
          isLoggedIn = false;
        } else {
          isLoggedIn = true;
          strMobileNumber = savedMobileNumber;
        }
      } on Exception catch (error) {

      };
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Gami",
        initialRoute: '/',
        navigatorKey: navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => makeRoute(
                context: context,
                routeName: settings.name,
                arguments: settings.arguments),
            maintainState: true,
            fullscreenDialog: false,
          );
        });
  }

  Future<void> didCheckForNotificationPermission() async {
    List<Permission> permissions = [Permission.notification];
    var result = await permissions.request();
    print(result.values.first);
    switch (result.values.first) {
      case PermissionStatus.granted:
        // do something
        didConfigureFirebasePushNotificationSettings();
        break;
      case PermissionStatus.denied:
        // do something
        AppSettings.openLocationSettings();
        break;
      case PermissionStatus.restricted:
        // do something
        break;
      default:
    }
  }

  Future selectNotification(String payload) async {
    _navigateToItemDetail(null);
  }

  didConfigureFirebasePushNotificationSettings() {
    _firebaseMessaging.autoInitEnabled().then((bool enabled) => print(enabled));
    _firebaseMessaging.setAutoInitEnabled(true).then((_) => _firebaseMessaging
        .autoInitEnabled()
        .then((bool enabled) => print(enabled)));
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("chekc");
        print("onMessage: $message");
        print('check');
        print("onMessage: ${message['notification']['body']}");
        _notifyUser(message);
        print("onMessage: ${message['notification']['body']}");
        print("onMessage: ${message['notification']['type']}");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
        // print("onResume: ${json.decode(json.encode(message))['type']}");
      },
    );
    var initializationSettingsIOS =
        IosNotificationSettings(sound: true, badge: true, alert: true);
    var initializationSettings =
        new InitializationSettings(iOS: IOSInitializationSettings());
    /*  flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);*/

    _firebaseMessaging
        .requestNotificationPermissions(initializationSettingsIOS);
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        print(token);
        PrefManager.putString("device_token", token);
      });
    });
  }

  void _notifyUser(message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'gami channel', 'gami Notifications', 'gami Notifications',
        importance: Importance.max,
        playSound: true,
        showProgress: true,
        priority: Priority.high,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotifications.show(0, message['notification']['title'],
        message['notification']['body'], platformChannelSpecifics);
  }

  Future<void> _navigateToItemDetail(Map<String, dynamic> message) async {
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    navigatorKey.currentState.push(MaterialPageRoute(
      builder: (context) => Tabbar(),
    ));
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  Widget makeRoute(
      {@required BuildContext context,
      @required String routeName,
      Object arguments}) {
    final Widget child = _buildRoute(
        context: context, routeName: routeName, arguments: arguments);
    return child;
  }

  Widget _buildRoute({
    @required BuildContext context,
    @required String routeName,
    Object arguments,
  }) {
    switch (routeName) {
      case '/':
        return isLoggedIn ? Loader() : OnboardingScreen() ;
      default:
        throw 'Route $routeName is not defined';
    }
  }
}
