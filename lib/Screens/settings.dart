import 'package:nutri/constants/export.dart';
import 'package:nutri/widget/custom_appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            appBar: CustomAppBar(
              title: "Settings",
              showLeading: true,
              onBackTap: () => Get.back(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Theme Settings Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: kDynamicCard(context),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kDynamicBorder(context)!, width: 1.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: "Appearance",
                          size: 18,
                          weight: FontWeight.w700,
                          color: kDynamicText(context),
                        ),
                        const Gap(16),
                        
                        // Theme Mode Selection
                        _buildThemeOption(
                          title: "Light Mode",
                          subtitle: "Always use light theme",
                          icon: Icons.light_mode_outlined,
                          isSelected: themeController.themeMode == ThemeMode.light,
                          onTap: () => themeController.switchTheme(ThemeMode.light),
                        ),
                        const Gap(12),
                        _buildThemeOption(
                          title: "Dark Mode", 
                          subtitle: "Always use dark theme",
                          icon: Icons.dark_mode_outlined,
                          isSelected: themeController.themeMode == ThemeMode.dark,
                          onTap: () => themeController.switchTheme(ThemeMode.dark),
                        ),
                        const Gap(12),
                        _buildThemeOption(
                          title: "System Default",
                          subtitle: "Follow system theme",
                          icon: Icons.phone_iphone_outlined,
                          isSelected: themeController.themeMode == ThemeMode.system,
                          onTap: () => themeController.switchTheme(ThemeMode.system),
                        ),
                      ],
                    ),
                  ),
                  
                  const Gap(20),
                  
                  // Quick Actions Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: kDynamicCard(context),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kDynamicBorder(context)!, width: 1.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: "Quick Actions",
                          size: 18,
                          weight: FontWeight.w700,
                          color: kDynamicText(context),
                        ),
                        const Gap(16),
                        
                        // Toggle Theme Button
                        Container(
                          width: double.infinity,
                          child: MyButtonWithIcon(
                            iconPath: isDarkMode ? Assets.funicalight : Assets.funicadark,
                            text: "Toggle Theme",
                            onTap: () => themeController.toggleTheme(),
                            backgroundColor: kDynamicPrimary(context)!,
                            fontColor: Colors.white,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const Gap(20),
                  
                  // Current Theme Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kDynamicPrimary(context)!.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isDarkMode ? Icons.dark_mode : Icons.light_mode,
                          color: kDynamicPrimary(context),
                          size: 24,
                        ),
                        const Gap(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: "Current Theme",
                                size: 14,
                                weight: FontWeight.w600,
                                color: kDynamicText(context),
                              ),
                              const Gap(2),
                              MyText(
                                text: isDarkMode ? "Dark Mode" : "Light Mode",
                                size: 12,
                                color: kDynamicListTileSubtitle(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildThemeOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected 
              ? kDynamicPrimary(Get.context!)!.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected 
                ? kDynamicPrimary(Get.context!)!
                : kDynamicBorder(Get.context!)!,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? kDynamicPrimary(Get.context!)
                  : kDynamicListTileSubtitle(Get.context!),
              size: 24,
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: title,
                    size: 16,
                    weight: FontWeight.w600,
                    color: kDynamicText(Get.context!),
                  ),
                  const Gap(2),
                  MyText(
                    text: subtitle,
                    size: 12,
                    color: kDynamicListTileSubtitle(Get.context!),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: kDynamicPrimary(Get.context!),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}