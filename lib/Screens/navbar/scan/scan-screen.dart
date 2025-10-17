import 'package:nutri/constants/back-stack.dart';
import 'package:nutri/constants/export.dart';
import 'package:nutri/extensions/media-query-extension.dart';
import 'package:nutri/widget/home-widgets/home-infocard.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
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
