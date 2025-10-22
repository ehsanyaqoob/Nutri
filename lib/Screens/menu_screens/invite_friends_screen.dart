import 'package:nutri/constants/back-stack.dart';
import 'package:nutri/constants/export.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
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
              title: 'Invite Friends',
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
    );
  }
}
