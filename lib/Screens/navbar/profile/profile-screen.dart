
import 'package:nutri/constants/export.dart';

class ProfileScreen extends StatefulWidget {
 const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Map<String, dynamic>> _settings = [
    {'icon': Assets.personfilled, 'title': 'Edit Profile', 'screenName': 'EditProfileScreen'},
    {'icon': Assets.loaction, 'title': 'Address', 'screenName': 'AddressScreen'},
    {'icon': Assets.notificationfilled, 'title': 'Notification', 'isToggle': true},
    {'icon': Assets.walletfilled, 'title': 'Payment', 'screenName': 'PaymentScreen'},
    {'icon': Assets.security, 'title': 'Security', 'screenName': 'SecurityScreen'},
    {'icon': Assets.language, 'title': 'Language', 'isLanguage': true, 'value': 'English (US)'},
    {'icon': Assets.eye, 'title': 'Dark Mode', 'isDarkMode': true},
    {'icon': Assets.privacy, 'title': 'Privacy Policy', 'screenName': 'PrivacyPolicyScreen'},
    {'icon': Assets.help, 'title': 'Help Center', 'screenName': 'HelpCenterScreen'},
    {'icon': Assets.invite, 'title': 'Invite Friends', 'screenName': 'InviteFriends'},
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: themeController.isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: themeController.isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            appBar: GenericAppBar(
              title: "Profile",
              
            ),
            body: const _ProfileBody(),
          ),
        );
      },
    );
  }
}

class _ProfileBody extends StatefulWidget {
  const _ProfileBody();

  @override
  State<_ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<_ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _ProfileHeader(),
            const Gap(32),
            _SettingsList(),
            const Gap(24),
            _LogoutButton(),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: kDynamicBorder(context), width: 2),
                  ),
                  child: ClipOval(
                    child: profileController.profileImage != null
                        ? Image.file(profileController.profileImage!, fit: BoxFit.cover, width: 100, height: 100)
                        : Container(
                            color: kDynamicContainer(context),
                            child: Center(
                              child: MyText(
                                text: profileController.userName
                                    .split(' ')
                                    .map((name) => name.isNotEmpty ? name[0] : '')
                                    .join('')
                                    .toUpperCase(),
                                size: 24,
                                weight: FontWeight.bold,
                                color: kDynamicText(context),
                              ),
                            ),
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => _showImagePickerBottomSheet(profileController),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: kDynamicContainer(context),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: kDynamicBorder(context), width: 2),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.pencilfilled,
                          height: 20,
                          colorFilter: ColorFilter.mode(kDynamicIcon(context), BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(16),
            MyText(text: profileController.userName, size: 22, weight: FontWeight.bold, color: kDynamicText(context)),
            const Gap(4),
            MyText(text: profileController.phone, size: 16, color: kDynamicSubtitleText(context)),
          ],
        );
      },
    );
  }

  void _showImagePickerBottomSheet(ProfileController controller) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: kDynamicCard(Get.context!),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: kDynamicBorder(Get.context!) ?? Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Gap(20),
              MyText(text: 'Change Profile Picture', size: 18, weight: FontWeight.bold, color: kDynamicText(Get.context!)),
              const Gap(20),
              ListTile(
                onTap: () {
                  Get.back();
                  controller.pickFromCamera();
                },
                leading: SvgPicture.asset(Assets.info, height: 24, colorFilter: ColorFilter.mode(kDynamicIcon(Get.context!), BlendMode.srcIn)),
                title: MyText(text: 'Take Photo', size: 16, color: kDynamicText(Get.context!), weight: FontWeight.w500),
              ),
              ListTile(
                onTap: () {
                  Get.back();
                  controller.pickFromGallery();
                },
                leading: SvgPicture.asset(Assets.info, height: 24, colorFilter: ColorFilter.mode(kDynamicIcon(Get.context!), BlendMode.srcIn)),
                title: MyText(text: 'Choose from Gallery', size: 16, color: kDynamicText(Get.context!), weight: FontWeight.w500),
              ),
              if (controller.profileImage != null)
                ListTile(
                  onTap: () {
                    Get.back();
                    controller.removeImage();
                  },
                  leading: SvgPicture.asset(Assets.delete, height: 24, colorFilter: ColorFilter.mode(kDynamicSystemRed(Get.context!)!, BlendMode.srcIn)),
                  title: MyText(text: 'Remove Photo', size: 16, color: kDynamicSystemRed(Get.context!)!, weight: FontWeight.w500),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsList extends StatelessWidget {
  final List<Map<String, dynamic>> _settings = [
    {'icon': Assets.personfilled, 'title': 'Edit Profile', 'screenName': 'EditProfileScreen'},
    {'icon': Assets.loaction, 'title': 'Address', 'screenName': 'AddressScreen'},
    {'icon': Assets.notificationfilled, 'title': 'Notification', 'isToggle': true},
    {'icon': Assets.walletfilled, 'title': 'Payment', 'screenName': 'PaymentScreen'},
    {'icon': Assets.security, 'title': 'Security', 'screenName': 'SecurityScreen'},
    {'icon': Assets.language, 'title': 'Language', 'isLanguage': true, 'value': 'English (US)'},
    {'icon': Assets.eye, 'title': 'Dark Mode', 'isDarkMode': true},
    {'icon': Assets.privacy, 'title': 'Privacy Policy', 'screenName': 'PrivacyPolicyScreen'},
    {'icon': Assets.help, 'title': 'Help Center', 'screenName': 'HelpCenterScreen'},
    {'icon': Assets.invite, 'title': 'Invite Friends', 'screenName': 'InviteFriends'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _settings.asMap().entries.map((entry) {
        final index = entry.key;
        final setting = entry.value;
        return Column(
          children: [
            ListTile(
              onTap: () => _handleSettingTap(setting),
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: kDynamicBackground(context),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    setting['icon'],
                    height: 26.0,
                    colorFilter: ColorFilter.mode(kDynamicIcon(context), BlendMode.srcIn),
                  ),
                ),
              ),
              title: MyText(text: setting['title'], size: 16.0, weight: FontWeight.w500, color: kDynamicText(context)),
              trailing: _buildTrailingWidget(setting),
            ),
            if (index < _settings.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(height: 1, color: kDynamicBorder(context) ),
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildTrailingWidget(Map<String, dynamic> setting) {
    if (setting['isToggle'] == true) {
      return GetBuilder<ProfileController>(
        builder: (controller) => Switch(
          value: controller.notificationsEnabled,
          onChanged: controller.toggleNotifications,
          activeColor: kPrimaryColor,
          activeTrackColor: kPrimaryColor.withOpacity(0.3),
        ),
      );
    }

    if (setting['isLanguage'] == true) {
      return GetBuilder<ProfileController>(
        builder: (controller) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText(text: setting['value'] ?? 'English (US)', size: 14, color: kDynamicSubtitleText(Get.context!)),
            const Gap(8),
            SvgPicture.asset(Assets.ahead, height: 16, colorFilter: ColorFilter.mode(kDynamicIcon(Get.context!), BlendMode.srcIn)),
          ],
        ),
      );
    }

    if (setting['isDarkMode'] == true) {
      return GetBuilder<ThemeController>(
        builder: (themeController) => Switch(
          value: themeController.isDarkMode,
          onChanged: (value) {
            final newMode = value ? ThemeMode.dark : ThemeMode.light;
            themeController.switchTheme(newMode);
          },
          activeColor: kPrimaryColor,
          activeTrackColor: kPrimaryColor.withOpacity(0.3),
        ),
      );
    }

    return SvgPicture.asset(Assets.ahead, height: 22.0, colorFilter: ColorFilter.mode(kDynamicIcon(Get.context!), BlendMode.srcIn));
  }

  void _handleSettingTap(Map<String, dynamic> setting) {
    if (setting['isLanguage'] == true) {
      _showLanguageBottomSheet();
      return;
    }

    if (setting['screenName'] != null) {
      _navigateToScreen(setting['screenName']!);
    }
  }

  void _navigateToScreen(String screenName) {
    switch (screenName) {
      case 'EditProfileScreen': AppToast.info('Screen coming soon'); break;
      case 'AddressScreen':AppToast.info('Screen coming soon'); break;
      case 'PaymentScreen':AppToast.info('Screen coming soon'); break;
      case 'SecurityScreen': AppToast.info('Screen coming soon'); break;
      case 'PrivacyPolicyScreen': AppToast.info('Screen coming soon'); break;
      case 'HelpCenterScreen': AppToast.info('Screen coming soon'); break;
      case 'InviteFriends': AppToast.info('Screen coming soon'); break;
      default: AppToast.info('Screen coming soon');
    }
  }

  void _showLanguageBottomSheet() {
    final languages = ['English (US)', 'Spanish', 'French', 'German', 'Chinese', 'Japanese'];
    final controller = Get.find<ProfileController>();

    Get.bottomSheet(
      Container(
        height: Get.height * 0.6,
        decoration: BoxDecoration(
          color: kDynamicCard(Get.context!),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: MyText(text: 'Select Language', size: 18, weight: FontWeight.bold, color: kDynamicText(Get.context!)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  return RadioListTile(
                    title: MyText(text: language, color: kDynamicText(context)),
                    value: language,
                    groupValue: controller.language,
                    onChanged: (value) {
                      controller.updateLanguage(value!);
                      Get.back();
                    },
                    activeColor: kPrimaryColor,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _showLogoutConfirmation(),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: SvgPicture.asset(
            Assets.personfilled,
            height: 26.0,
            colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
          ),
        ),
      ),
      title: MyText(
        text: 'Logout', 
        size: 16.0, 
        weight: FontWeight.w500, 
        color: Colors.red
      ),
      trailing: SvgPicture.asset(
        Assets.ahead, 
        height: 22.0, 
        colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn)
      ),
    );
  }

  void _showLogoutConfirmation() {
    Get.dialog(
      AlertDialog(
        backgroundColor: kDynamicCard(Get.context!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: MyText(
          text: 'Logout',
          size: 20,
          weight: FontWeight.bold,
          color: kDynamicText(Get.context!),
        ),
        content: MyText(
          text: 'Are you sure you want to logout?',
          size: 16,
          color: kDynamicSubtitleText(Get.context!),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: MyText(
              text: 'Cancel',
              color: kDynamicSubtitleText(Get.context!),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.find<ProfileController>().logout();
            },
            child: MyText(
              text: 'Logout',
              color: Colors.red,
              weight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}