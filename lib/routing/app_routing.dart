import 'package:bank_app/constants/route_constants.dart';
import 'package:bank_app/screens/balance_screen.dart';
import 'package:bank_app/screens/history.dart';
import 'package:bank_app/screens/profile.dart';
import 'package:bank_app/screens/send_money.dart';
import 'package:bank_app/screens/splash_screen.dart';
import 'package:bank_app/screens/transfer_money_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';

class AppRouter{
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: RouteConstants.splash_screen,
        pageBuilder: (context,state){
          return const MaterialPage(child: SplashScreen());
        }
      ),
      GoRoute(
        path: RouteConstants.login,
        pageBuilder: (context, state){
          return const MaterialPage(child: LoginScreen());
        }
      ),
      GoRoute(
          path: RouteConstants.register,
          pageBuilder: (context, state){
            return const MaterialPage(child: RegisterScreen());
          }
      ),
      GoRoute(
          path: RouteConstants.home,
          pageBuilder: (context, state){
            return const MaterialPage(child: HomeScreen());
          }
      ),
      GoRoute(
          path: RouteConstants.transfer,
          pageBuilder: (context, state){
            return const MaterialPage(child: TransferMoney());
          }
      ),
      GoRoute(
          path: RouteConstants.sendMoney,
          pageBuilder: (context, state){
            return const MaterialPage(child: SendMoney());
          }
      ),
      GoRoute(
          path: RouteConstants.profile,
          pageBuilder: (context, state){
            return const MaterialPage(child: ProfileScreen());
          }
      ),
      GoRoute(
          path: RouteConstants.balance,
          pageBuilder: (context, state){
            return const MaterialPage(child: BalanceScreen());
          }
      ),
      GoRoute(
          path: RouteConstants.histroy,
          pageBuilder: (context, state){
            return const MaterialPage(child: History());
          }
      ),
    ]
  );
}