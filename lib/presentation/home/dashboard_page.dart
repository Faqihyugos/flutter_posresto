// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posresto/core/core.dart';
import 'package:flutter_posresto/data/datasources/auth_local_datasource.dart';
import 'package:flutter_posresto/data/models/response/auth_response_model.dart';

import '../auth/bloc/bloc/logout_bloc.dart';
import '../auth/login_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  User? user;

  @override
  void initState() {
    AuthLocalDataSource().getAuthData().then((value) {
      setState(() {
        user = value.user;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Text("Welcome to Dashboard"),
              Text('Name: ${user?.name ?? ''}'),
              const SizedBox(
                height: 10.0,
              ),
              BlocListener<LogoutBloc, LogoutState>(
                listener: (context, state) {
                  state.maybeMap(
                    orElse: () {},
                    error: (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.message),
                        ),
                      );
                    },
                    success: (value) {
                      AuthLocalDataSource().removeAuthData();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logout success'),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }), (route) => false);
                    },
                  );
                },
                child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<LogoutBloc>()
                          .add(const LogoutEvent.logout());
                    },
                    child: const Text("Logout")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
