import 'package:nutri/constants/back-stack.dart';
import 'package:nutri/constants/export.dart';

class DayMealScreen extends StatefulWidget {
  const DayMealScreen({super.key});

  @override
  State<DayMealScreen> createState() => _DayMealScreenState();
}

class _DayMealScreenState extends State<DayMealScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
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
          child: Scaffold(              appBar: GenericAppBar(title: "Day Meal "),
    
            backgroundColor: kDynamicScaffoldBackground(context),
            body: SingleChildScrollView(
              child: Padding(
                padding: AppSizes.DEFAULT,
                child: Column(children: [40.height, 
                
                MyText(
                    text: 'Plan Your Day Meal',
                    size: 20,
                    color: kDynamicText(context),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
