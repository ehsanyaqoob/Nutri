import 'package:nutri/constants/back-stack.dart';
import 'package:nutri/constants/export.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
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
          child: Scaffold(
            appBar: CustomAppBar(
              title: 'My Address',
              centerTitle: false,
              showLeading: true,
              onBackTap: () {
                Get.back();
              },
            ),
            backgroundColor: kDynamicScaffoldBackground(context),
            body: SingleChildScrollView(
              child: Padding(
                padding: AppSizes.DEFAULT,
                child: Column(children: [40.height, const Gap(20)]),
              ),
            ),
          ),
        );
      },
    );
  }
}
