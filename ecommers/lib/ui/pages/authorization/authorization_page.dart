import 'package:ecommers/core/provider_models/base_provider_model.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/provider_models/log_in_provider_model.dart';
import 'package:ecommers/core/provider_models/sign_up_provider_model.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/authorization/forgot_password_page.dart';
import 'package:ecommers/ui/pages/authorization/log_in_page.dart';
import 'package:ecommers/ui/pages/authorization/sign_up_page.dart';
import 'package:ecommers/ui/pages/busy_page.dart';
import 'package:ecommers/ui/widgets/backgrounded_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage>
    with SingleTickerProviderStateMixin {
  TabController currentTabController;
  @override
  void initState() {
    currentTabController =
        TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabStyle = Theme.of(context).textTheme.headline6;
    final localization = I18n.of(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LogInProviderModel(
            context,
            bottomTapCallback: _createANewAccountClicked,
          ),
        ),
        ChangeNotifierProvider(create: (_) => SignUpProviderModel(context)),
        ChangeNotifierProxyProvider2<SignUpProviderModel, LogInProviderModel,
            BusyProviderModel>(
          create: (_) => BusyProviderModel(),
          update: (_, signUpProvider, loginProvider, busyProvider) =>
              busyProvider
                ..isBusy = signUpProvider.isBusy || loginProvider.isBusy,
        ),
      ],
      child: BusyPage<BusyProviderModel>(
        child: BackgroundedSafeArea(
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: BrandingColors.pageBackground,
              appBar: AppBar(
                bottom: TabBar(
                  controller: currentTabController,
                  tabs: <Widget>[
                    Tab(text: localization.signUp),
                    Tab(text: localization.logIn),
                    Tab(text: localization.forgotPassword),
                  ],
                  indicatorColor: Colors.transparent,
                  labelStyle: tabStyle,
                  labelColor: tabStyle.color,
                  unselectedLabelColor: tabStyle.color.withOpacity(0.2),
                  isScrollable: true,
                ),
              ),
              body: TabBarView(
                controller: currentTabController,
                children: <Widget>[
                  SignUpPage(),
                  LogInPage(),
                  ForgotPasswordPage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _createANewAccountClicked() {
    setState(
      () => {
        currentTabController.animateTo(0),
      },
    );
  }
}
