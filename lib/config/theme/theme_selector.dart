import 'package:nutri/constants/export.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('App Theme', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: [
              // Light theme option
              ChoiceChip(
                label: Text('Light'),
                selected: themeController.themeMode == ThemeMode.light,
                onSelected: (_) => themeController.switchTheme(ThemeMode.light),
              ),
              // Dark theme option
              ChoiceChip(
                label: Text('Dark'),
                selected: themeController.themeMode == ThemeMode.dark,
                onSelected: (_) => themeController.switchTheme(ThemeMode.dark),
              ),
              // System theme option
              ChoiceChip(
                label: Text('System'),
                selected: themeController.themeMode == ThemeMode.system,
                onSelected: (_) =>
                    themeController.switchTheme(ThemeMode.system),
              ),
            ],
          ),
        ],
      );
    });
  }
}
