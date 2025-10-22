import 'package:nutri/constants/back-stack.dart';
import 'package:nutri/constants/export.dart';
import 'package:nutri/widget/bottomsheets/helper-sheets.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final AuthController authController = Get.find<AuthController>();
  final List<Map<String, dynamic>> _settings = [
    {
      'icon': Assets.personfilled,
      'title': 'Edit Profile',
      'route': AppLinks.editProfile,
    },
    {'icon': Assets.loaction, 'title': 'Address', 'route': AppLinks.address},
    {
      'icon': Assets.notificationfilled,
      'title': 'Notification',
      'isToggle': true,
    },
    {
      'icon': Assets.walletfilled,
      'title': 'Payment',
      'route': AppLinks.payment,
    },
    {'icon': Assets.security, 'title': 'Security', 'route': AppLinks.security},
    {
      'icon': Assets.language,
      'title': 'Language',
      'isLanguage': true,
      'value': 'English (US)',
    },
    {'icon': Assets.eye, 'title': 'Dark Mode', 'isDarkMode': true},
    {
      'icon': Assets.privacy,
      'title': 'Privacy Policy',
      'route': AppLinks.privacyPolicy,
    },
    {'icon': Assets.help, 'title': 'Help Center', 'route': AppLinks.helpCenter},
    {
      'icon': Assets.invite,
      'title': 'Invite Friends',
      'route': AppLinks.inviteFriends,
    },
  ];

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
          child: WillPopScope(
            onWillPop: BackPressHandler.handleBackPress,

            child: Scaffold(
              backgroundColor: kDynamicScaffoldBackground(context),
              appBar: GenericAppBar(title: "Profile"),
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: AppSizes.DEFAULT,
                    child: Column(
                      children: [
                        _ProfileHeader(),
                        8.0.height,
                        Divider(
                          color: kDynamicDivider(context),
                          thickness: 1.6,
                        ),
                        8.0.height,
                        _SettingsList(),
                        Divider(
                          color: kDynamicDivider(context),
                          thickness: 1.6,
                        ),
                        8.0.height,
                        _LogoutButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _ProfileHeader() {
    final ProfileController profileController = Get.find<ProfileController>();

    return Column(
      children: [
        Stack(
          children: [
            Obx(() {
              final hasImage = profileController.hasProfileImage;
              final profileImage = profileController.profileImage;

              return Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kDynamicBorder(context),
                    width: 4.0,
                  ),
                ),
                child: ClipOval(
                  child: hasImage && profileImage != null
                      ? Image.file(
                          profileImage,
                          fit: BoxFit.cover,
                          width: 130,
                          height: 130,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildInitialsContainer();
                          },
                        )
                      : _buildInitialsContainer(),
                ),
              );
            }),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => _showImagePickerBottomSheet(),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: kDynamicContainer(context),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: kDynamicBorder(context),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.pencilfilled,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        kDynamicIcon(context),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Gap(6.0),
        Obx(
          () => MyText(
            text: authController.userName.value,
            size: 22,
            weight: FontWeight.bold,
            color: kDynamicText(context),
          ),
        ),
        const Gap(4),
        Obx(
          () => MyText(
            text: authController.userEmail.value,
            size: 16,
            color: kDynamicSubtitleText(context),
          ),
        ),
      ],
    );
  }

  // Helper method to build initials container
  Widget _buildInitialsContainer() {
    return GetBuilder<AuthController>(
      builder: (authController) {
        final userName = authController.userName.value;

        // Extract initials from user name
        final initials = _getUserInitials(userName);

        return Container(
          color: kDynamicContainer(Get.context!),
          child: Center(
            child: MyText(
              text: initials,
              size: 32,
              weight: FontWeight.bold,
              color: kDynamicText(Get.context!),
            ),
          ),
        );
      },
    );
  }

  String _getUserInitials(String userName) {
    if (userName.isEmpty) return 'NU';

    final nameParts = userName.trim().split(' ');

    if (nameParts.length == 1) {
      return nameParts[0].length >= 2
          ? nameParts[0].substring(0, 2).toUpperCase()
          : nameParts[0].toUpperCase();
    } else {
      final firstInitial = nameParts[0].isNotEmpty ? nameParts[0][0] : '';
      final secondInitial = nameParts[1].isNotEmpty ? nameParts[1][0] : '';
      return '${firstInitial}${secondInitial}'.toUpperCase();
    }
  }

  void _showImagePickerBottomSheet() {
    BottomSheetHelper.showImagePickerSheet(
      onCameraTap: () => Get.find<ProfileController>().pickFromCamera(),
      onGalleryTap: () => Get.find<ProfileController>().pickFromGallery(),
      onRemoveTap: () => Get.find<ProfileController>().removeImage(),
      showRemoveOption: Get.find<ProfileController>().hasProfileImage,
    );
  }

  void _showLogoutConfirmation() {
    Get.find<ProfileController>().logout();
  }

  Widget _SettingsList() {
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
                    colorFilter: ColorFilter.mode(
                      kDynamicIcon(context),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              title: MyText(
                text: setting['title'],
                size: 16.0,
                weight: FontWeight.w500,
                color: kDynamicText(context),
              ),
              trailing: _buildTrailingWidget(setting),
            ),
            if (index < _settings.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(height: 1, color: kDynamicBorder(context)),
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildTrailingWidget(Map<String, dynamic> setting) {
    if (setting['isToggle'] == true) {
      return Switch(
        value: true,
        onChanged: (value) {
          AppToast.info('Notifications ${value ? 'enabled' : 'disabled'}');
        },
        activeColor: kPrimaryColor,
        activeTrackColor: kPrimaryColor.withOpacity(0.3),
      );
    }

    if (setting['isLanguage'] == true) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyText(
            text: setting['value'] ?? 'English (US)',
            size: 14,
            color: kDynamicSubtitleText(Get.context!),
          ),
          const Gap(8),
          SvgPicture.asset(
            Assets.ahead,
            height: 16,
            colorFilter: ColorFilter.mode(
              kDynamicIcon(Get.context!),
              BlendMode.srcIn,
            ),
          ),
        ],
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

    return SvgPicture.asset(
      Assets.ahead,
      height: 22.0,
      colorFilter: ColorFilter.mode(
        kDynamicIcon(Get.context!),
        BlendMode.srcIn,
      ),
    );
  }

  void _handleSettingTap(Map<String, dynamic> setting) {
    if (setting['isLanguage'] == true) {
      _showLanguageBottomSheet();
      return;
    }

    if (setting['route'] != null) {
      NavigationHelper.navigateTo(setting['route']!);
    }
  }

  void _showLanguageBottomSheet() {
    final languages = [
      'English (US)',
      'Spanish',
      'French',
      'German',
      'Chinese',
      'Japanese',
    ];

    Get.bottomSheet(
      Container(
        height: Get.height * 0.6,
        decoration: BoxDecoration(
          color: kDynamicCard(Get.context!),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: MyText(
                text: 'Select Language',
                size: 18,
                weight: FontWeight.bold,
                color: kDynamicText(Get.context!),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  return RadioListTile(
                    title: MyText(text: language, color: kDynamicText(context)),
                    value: language,
                    groupValue: 'English (US)',
                    onChanged: (value) {
                      AppToast.info('Language changed to $value');
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

  Widget _LogoutButton() {
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
        color: Colors.red,
      ),
      trailing: SvgPicture.asset(
        Assets.ahead,
        height: 22.0,
        colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
      ),
    );
  }
}
