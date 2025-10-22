import 'package:nutri/constants/back-stack.dart';
import 'package:nutri/constants/export.dart';
import 'package:nutri/extensions/media-query-extension.dart';
import 'package:nutri/widget/home-widgets/home-infocard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: BackPressHandler.handleBackPress,
      child: GetBuilder<ThemeController>(
        builder: (themeController) {
          final bool isDarkMode = themeController.isDarkMode;

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: isDarkMode
                  ? Brightness.light
                  : Brightness.dark,
              systemNavigationBarColor: kDynamicScaffoldBackground(context),
              systemNavigationBarIconBrightness: isDarkMode
                  ? Brightness.light
                  : Brightness.dark,
            ),
            child: Scaffold(
              backgroundColor: kDynamicScaffoldBackground(context),
              body: SingleChildScrollView(
                child: Padding(
                  padding: AppSizes.DEFAULT,
                  child: Column(
                    children: [
                      40.height,
                      UserInfoRow(
                        onAvatarTap: () =>
                            Get.toNamed(AppLinks.profile, arguments: null),
                        onNotificationTap: () => Get.toNamed(AppLinks.notify),
                      ),
                      10.height,
                      MyText(
                        text: 'Calendar View',
                        size: 20,
                        color: kDynamicText(context),
                      ),10.height,
                      MyText(
                        text: 'Calendar View',
                        size: 20,
                        color: kDynamicText(context),
                      ),10.height,
                      MyText(
                        text: 'Calendar View',
                        size: 20,
                        color: kDynamicText(context),
                      ),

                      const Gap(20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
