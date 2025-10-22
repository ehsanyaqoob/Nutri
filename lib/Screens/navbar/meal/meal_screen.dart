import 'package:nutri/constants/back-stack.dart';
import 'package:nutri/constants/export.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
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
