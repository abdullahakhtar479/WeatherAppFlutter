import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'login_screen.dart';
import 'styles.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/assets/cloudy.png'),
            SizedBox(height: 24),
            Text(
              'WeatherApp',
              style: AppTextStyles.heading.copyWith(color: AppColors.primary),
            ),
            SizedBox(height: 24),
            SpinKitFadingCube(
              color: AppColors.primary,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
