import 'package:country_picker/country_picker.dart';
import 'package:intl/intl.dart';
import 'package:nutri/constants/export.dart' hide Country;
import 'package:nutri/widget/dot-loader.dart';
import 'package:nutri/widget/toasts.dart';

class FillUpProfileDetailScreen extends StatefulWidget {
  const FillUpProfileDetailScreen({super.key});

  @override
  State<FillUpProfileDetailScreen> createState() =>
      _FillUpProfileDetailScreenState();
}

class _FillUpProfileDetailScreenState extends State<FillUpProfileDetailScreen> {
  final ProfileController _controller = Get.find<ProfileController>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: themeController.isDarkMode
                ? Brightness.light
                : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: themeController.isDarkMode
                ? Brightness.light
                : Brightness.dark,
          ),
          child: Stack(
            children: [
              Scaffold(
                backgroundColor: kDynamicScaffoldBackground(context),
                appBar: CustomAppBar(
                  title: 'Edit Profile'.tr,
                  showLeading: true,
                  onBackTap: () => Get.back(),
                ),
                body: _ProfileContent(onSave: _submitProfile),
              ),

              if (_isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NutriLoader(),
                        Gap(4),
                        MyText(text: "Updating Profile...",
                        size: 12.0,

                         color: kDynamicText(context),),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _submitProfile(Map<String, dynamic> profileData) async {
    if (_validateForm(profileData)) {
      setState(() => _isLoading = true);

      // Show FunicaLoader for 2 seconds
      await Future.delayed(const Duration(seconds: 2));

      // Update profile data
      _controller.updateUserName(profileData['fullName']!);
      _controller.updateEmail(profileData['email']!);
      _controller.updatePhone(profileData['phone']!);

      AppToast.success('Profile updated successfully');

      // Exit screen
      Get.back();
    }
  }

  bool _validateForm(Map<String, dynamic> profileData) {
    if (profileData['fullName']!.isEmpty) {
      AppToast.error('Please enter your full name'.tr);
      return false;
    }
    if (profileData['email']!.isEmpty || !profileData['email']!.contains('@')) {
      AppToast.error('Please enter a valid email'.tr);
      return false;
    }
    if (profileData['phone']!.isEmpty) {
      AppToast.error('Please enter your phone number'.tr);
      return false;
    }
    return true;
  }
}

class _ProfileContent extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  const _ProfileContent({required this.onSave});

  @override
  State<_ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<_ProfileContent> {
  final ProfileController _controller = Get.find<ProfileController>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _loadExistingData();
    _selectedCountry = Country(
      phoneCode: "1",
      countryCode: "US",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "United States",
      example: "United States",
      displayName: "United States",
      displayNameNoCountryCode: "US",
      e164Key: "",
    );
    _countryCodeController.text = '+${_selectedCountry!.phoneCode}';
  }

  void _loadExistingData() {
    _fullNameController.text = _controller.userName;
    _emailController.text = _controller.email;
    _phoneController.text = _controller.phone.replaceFirst('+1 ', '');
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(
        () => _dateController.text = DateFormat("dd/MMM/yyyy").format(picked),
      );
    }
  }

  void _showGenderBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: AppSizes.DEFAULT,
        decoration: BoxDecoration(
          color: kDynamicScaffoldBackground(context),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: kDynamicText(context),
                  ),
                ),
              ],
            ),
            const Gap(16),
            MyText(
              text: "Select Gender".tr,
              size: 18,
              color: kDynamicText(context),
              weight: FontWeight.bold,
            ),
            const Gap(20),
            ...['Male', 'Female', 'Other']
                .map(
                  (gender) => Bounce(
                    onTap: () {
                      setState(() => _genderController.text = gender);
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: kDynamicContainer(context),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: gender.tr,
                            size: 14,
                            weight: FontWeight.w500,
                            color: kDynamicSubtitleText(context),
                          ),
                          if (_genderController.text == gender)
                            Icon(Icons.check, color: kPrimaryColor),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
          _countryCodeController.text = '+${country.phoneCode}';
        });
      },
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: kDynamicModalBackground(context),
        textStyle: TextStyle(color: kDynamicText(context)),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  Map<String, dynamic> _getProfileData() {
    return {
      'fullName': _fullNameController.text,
      'email': _emailController.text,
      'phone': '${_countryCodeController.text}${_phoneController.text}',
      'dateOfBirth': _dateController.text,
      'gender': _genderController.text,
    };
  }

  void _handleSave() {
    widget.onSave(_getProfileData());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const Gap(20),
            _buildFormFields(),
            const Gap(20),
            _buildSaveButton(),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        MyTextField(
          controller: _fullNameController,
          hint: "Full Name".tr,
          prefix: SvgPicture.asset(
            Assets.personfilled,
            height: 20,
            colorFilter: ColorFilter.mode(
              kDynamicIcon(context),
              BlendMode.srcIn,
            ),
          ),
        ),
        const Gap(12),
        MyTextField(
          controller: _dateController,
          hint: "Date of Birth".tr,
          suffix: SvgPicture.asset(
            Assets.calendarfilled,
            colorFilter: ColorFilter.mode(
              kDynamicIcon(context),
              BlendMode.srcIn,
            ),
          ),
          onTap: _selectDate,
        ),
        const Gap(12),
        MyTextField(
          controller: _genderController,
          hint: "Gender".tr,
          suffix: SvgPicture.asset(
            Assets.pencilfilled,
            height: 20,
            colorFilter: ColorFilter.mode(
              kDynamicIcon(context),
              BlendMode.srcIn,
            ),
          ),
          onTap: _showGenderBottomSheet,
        ),
        const Gap(12),
        MyTextField(
          controller: _emailController,
          hint: "Email".tr,
          keyboardType: TextInputType.emailAddress,
          prefix: SvgPicture.asset(
            Assets.emailfilled,
            colorFilter: ColorFilter.mode(
              kDynamicIcon(context),
              BlendMode.srcIn,
            ),
          ),
        ),
        const Gap(12),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: MyTextField(
                controller: _countryCodeController,
                hint: "+1",
                isReadOnly: true,
                onTap: _showCountryPicker,
                prefix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyText(text: _selectedCountry?.flagEmoji ?? "🌍", size: 20),
                    const Gap(6),
                    MyText(
                      text: "+${_selectedCountry?.phoneCode ?? ''}",
                      size: 16,
                      color: kDynamicText(context),
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            const Gap(8),
            Expanded(
              child: MyTextField(
                controller: _phoneController,
                hint: "Phone Number".tr,
                keyboardType: TextInputType.phone,
                prefix: SvgPicture.asset(
                  Assets.phonefilled,
                  colorFilter: ColorFilter.mode(
                    kDynamicIcon(context),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return MyButton(buttonText: "Save Changes".tr, onTap: _handleSave);
  }
}
