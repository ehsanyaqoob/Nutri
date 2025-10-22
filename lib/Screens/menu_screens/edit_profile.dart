import 'package:nutri/constants/export.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
              title: 'Edit Profile',
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
