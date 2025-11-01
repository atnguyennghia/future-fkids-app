import 'package:futurekids/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthService.to.hasLogin ? null : const RouteSettings(name: '/auth/login');
  }
}