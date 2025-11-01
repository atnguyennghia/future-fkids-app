import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// Thay thế các imports service bằng service thực tế của bạn
import 'package:futurekids/services/setting_service.dart'; 
import 'package:futurekids/services/stt_service.dart';
import 'package:flutter/foundation.dart';
import 'package:futurekids/routes/app_routes.dart';
import 'package:futurekids/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart'; // Sử dụng Get thay vì MaterialApp đơn thuần
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// Import có điều kiện cho web
import 'callable_function_app.dart'
    if (dart.library.html) 'callable_function.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // --- 1. Khởi tạo Firebase và Xử lý Lỗi ---
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAnalytics.instance.logAppOpen();
    
    // Chỉ thiết lập Crashlytics nếu Firebase khởi tạo thành công
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  } catch (e) {
    // In ra lỗi và sử dụng cơ chế xử lý lỗi mặc định nếu Firebase thất bại
    print('Firebase initialization failed: $e'); 
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };
  }
  
  // --- 2. Khởi tạo Services ---
  await initServices();

  // --- 3. Cài đặt Giao diện Hệ thống ---
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
    // Chạy hàm callableFunction sau khi runApp
    callableFunction(); 
  });
}

// Khởi tạo các Services của bạn
Future<void> initServices() async {
  await GetStorage.init();
  // Giả định các service này có thật trong project của bạn
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => SettingService().init());
  await Get.putAsync(() => STTService().init());
}

// --- MyApp (Root Widget) ---
// Sử dụng GetMaterialApp và giữ lại cấu trúc StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Sử dụng Key? key thay vì super.key

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Sử dụng GetMaterialApp từ get
      title: 'Fkids - Kiến tạo nhân tài Việt', // Title từ version cũ
      scrollBehavior: MyCustomScrollBehavior(), // ScrollBehavior từ version cũ
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Route ban đầu
      getPages: AppRoutes.getPages, // Routes từ version cũ
      theme: ThemeData( // Theme từ version mới (có thể chỉnh sửa để match theme cũ)
        fontFamily: 'Quicksand', // Font từ version cũ
        // Sử dụng ColorScheme.fromSeed để có theme hiện đại hơn nếu muốn
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), 
        // Dùng theme cơ bản nếu chỉ cần fontFamily
      ),
      // Giữ MyHomePage như một ví dụ, nhưng có thể thay bằng màn hình khởi đầu thực tế của bạn
      // home: const MyHomePage(title: 'Flutter Demo Home Page'), 
    );
  }
}

// --- Custom Scroll Behavior (Từ version cũ) ---
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
