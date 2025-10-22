import 'package:nutri/constants/back-stack.dart';
import 'package:nutri/constants/export.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
              title: 'Privacy Policy',
              centerTitle: false,
              showLeading: true,
              onBackTap: () {
                Get.back();
              },
            ),
            backgroundColor: kDynamicScaffoldBackground(context),
            body: SingleChildScrollView(
              padding: AppSizes.DEFAULT,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  
                  // Header
                  Center(
                    child: MyText(
                      text: "Privacy Policy",
                      size: 24,
                      weight: FontWeight.bold,
                      color: kDynamicText(context),
                    ),
                  ),
                  20.height,
                  
                  MyText(
                    text: "Last updated: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                    size: 14,
                    color: kDynamicText(context)!.withOpacity(0.7),
                  ),
                  30.height,

                  // Section 1: Data Collection
                  _buildSectionTitle("1. Information We Collect"),
                  15.height,
                  
                  _buildParagraph(
                    "At Nutri AI, we collect information to provide you with personalized nutrition tracking and AI-powered food analysis services. "
                    "This includes:",
                  ),
                  10.height,
                  
                  _buildBulletPoint(
                    "Food Images & Scan Data: When you use our scanning feature, we process images of your food to provide nutritional analysis, calorie estimates, and ingredient recognition."
                  ),
                  8.height,
                  
                  _buildBulletPoint(
                    "Health & Nutrition Data: We store your food logs, calorie intake, macronutrient information, dietary preferences, and health goals to deliver personalized recommendations."
                  ),
                  8.height,
                  
                  _buildBulletPoint(
                    "Device Information: We collect technical information about your device to optimize the scanning and analysis functionality."
                  ),
                  25.height,

                  // Section 2: How We Use Your Data
                  _buildSectionTitle("2. How We Use Your Information"),
                  15.height,
                  
                  _buildParagraph(
                    "We use your personal information for the following primary purposes:"
                  ),
                  10.height,
                  
                  _buildBulletPoint(
                    "AI-Powered Food Analysis: To analyze your food images and provide accurate nutritional information, calorie counts, and health insights using our machine learning algorithms."
                  ),
                  8.height,
                  
                  _buildBulletPoint(
                    "•Personalized Nutrition Tracking: To track your dietary patterns, monitor your progress towards health goals, and suggest improvements to your eating habits."
                  ),
                  8.height,
                  
                  _buildBulletPoint(
                    "•Service Improvement: To enhance our scanning technology, improve food recognition accuracy, and develop new features for better nutrition tracking."
                  ),
                  25.height,

                  // Section 3: Data Storage & Security
                  _buildSectionTitle("3. Data Security & Storage"),
                  15.height,
                  
                  _buildParagraph(
                    "We take the security of your health and nutrition data seriously:"
                  ),
                  10.height,
                  
                  _buildBulletPoint(
                    " Secure Storage: Your food scans, nutrition data, and personal information are stored on encrypted servers with industry-standard security measures."
                  ),
                  8.height,
                  
                  _buildBulletPoint(
                    " Local Processing: Some food image processing occurs locally on your device to minimize data transmission and enhance privacy."
                  ),
                  8.height,
                  
                  _buildBulletPoint(
                    " Data Retention: We retain your food logs and scan history only as long as necessary to provide our services. You can delete your data at any time through app settings."
                  ),
                  25.height,

                  // Section 4: Third-Party Sharing
                  _buildSectionTitle("4. Third-Party Services"),
                  15.height,
                  
                  _buildParagraph(
                    "We do not sell your personal data to third parties. However, we may share information with:"
                  ),
                  10.height,
                  
                  _buildBulletPoint(
                    " Cloud Service Providers: For secure data storage and processing capabilities required for our AI food analysis."
                  ),
                  8.height,
                  
                  _buildBulletPoint(
                    " Analytics Services: To understand app usage patterns and improve user experience (data is anonymized where possible)."
                  ),
                  25.height,

                  // Section 5: Your Rights
                  _buildSectionTitle("5. Your Privacy Rights"),
                  15.height,
                  
                  _buildParagraph(
                    "You have control over your data:"
                  ),
                  10.height,
                  
                  _buildBulletPoint(
                    "Access & Export: You can access and export your nutrition data and food logs at any time."
                  ),
                  8.height,
                  
                  _buildBulletPoint(
                    " Deletion: You can request deletion of your account and all associated data, including food scan history and nutrition logs."
                  ),
                  8.height,
                  
                  _buildBulletPoint(
                    "Camera Permissions: You can enable or disable camera access for food scanning in your device settings."
                  ),
                  25.height,

                  // Section 6: Contact
                  _buildSectionTitle("6. Contact Us"),
                  15.height,
                  
                  _buildParagraph(
                    "If you have any questions about this Privacy Policy or our data practices, please contact us at:"
                  ),
                  15.height,
                  
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: kPrimaryColor.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: "Email: privacy@nutriapp.com",
                          size: 16,
                          weight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                        8.height,
                        MyText(
                          text: "We typically respond within 24-48 hours.",
                          size: 14,
                          color: kDynamicText(context)!.withOpacity(0.7),
                        ),
                      ],
                    ),
                  ),
                  40.height,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String text) {
    return MyText(
      text: text,
      size: 18,
      weight: FontWeight.bold,
      color: kPrimaryColor,
    );
  }

  Widget _buildParagraph(String text) {
    return MyText(
      text: text,
      size: 16,
      color: kDynamicText(context),
      lineHeight: 1.5,
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: "• ",
          size: 16,
          color: kDynamicText(context),
        ),
        Expanded(
          child: MyText(
            text: text,
            size: 16,
            color: kDynamicText(context),
            lineHeight: 1.5,
          ),
        ),
      ],
    );
  }
}