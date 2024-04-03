import 'package:flutter/material.dart';
import 'package:flutter_posresto/presentation/home/dashboard_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

import '../../components/buttons.dart';
import '../../components/custom_text_field.dart';
import '../../components/spaces.dart';
import '../../core/assets/assets.gen.dart';
import '../../core/core.dart';
// import '../../home/pages/main_nav_desktop.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 124.0, vertical: 20.0),
        children: [
          const SpaceHeight(80.0),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 130.0),
              child: SvgPicture.asset(
                Assets.icons.homeResto.path,
                width: 100,
                height: 100,
                color: AppColors.primary,
              )),
          const SpaceHeight(24.0),
          const Center(
            child: Text(
              'POS RESTO BIZAN',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SpaceHeight(8.0),
          const Center(
            child: Text(
              'Akses Login Kasir',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
          const SpaceHeight(40.0),
          CustomTextField(
            controller: emailController,
            label: 'Email',
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            obscureText: true,
          ),
          const SpaceHeight(24.0),
          Button.filled(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardPage(),
                ),
              );
            },
            label: 'Masuk',
          ),
        ],
      ),
    );
  }
}
