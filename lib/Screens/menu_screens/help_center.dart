import 'package:nutri/constants/back-stack.dart';
import 'package:nutri/constants/export.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final List<FAQItem> _faqs = [
    FAQItem(
      question: "How accurate is the food scanning feature?",
      answer: "Our AI-powered food scanner uses advanced machine learning to identify foods and estimate nutritional values. While we strive for high accuracy, results may vary based on food complexity, lighting, and image quality. For best results, ensure good lighting and clear food images.",
      isExpanded: false,
    ),
    FAQItem(
      question: "How do I scan my food properly?",
      answer: "• Ensure good lighting\n• Place food on a contrasting background\n• Capture the entire meal in frame\n• Avoid blurry images\n• Scan before eating for accurate portion tracking\n• Use multiple angles for complex meals",
      isExpanded: false,
    ),
    FAQItem(
      question: "Can I manually add food items?",
      answer: "Yes! You can manually add food items through the 'Add Food' feature. Search our extensive database or create custom food items with specific nutritional information.",
      isExpanded: false,
    ),
    FAQItem(
      question: "How does calorie tracking work?",
      answer: "We calculate calories based on:\n• AI analysis of scanned food images\n• Portion size estimation\n• Nutritional database matching\n• Your personal profile (age, weight, goals)\n• Historical eating patterns",
      isExpanded: false,
    ),
    FAQItem(
      question: "Why is my scan not recognizing certain foods?",
      answer: "Some foods may be challenging to recognize due to:\n• Mixed dishes or complex recipes\n• Uncommon or regional foods\n• Poor image quality\n\nTry: Taking clearer photos, separating food items, or manually adding unrecognized foods.",
      isExpanded: false,
    ),
    FAQItem(
      question: "How do I set my nutrition goals?",
      answer: "Go to Profile → Goals to set:\n• Daily calorie targets\n• Macronutrient ratios (carbs, protein, fat)\n• Weight management goals\n• Dietary preferences (keto, vegan, etc.)\n• Allergen restrictions",
      isExpanded: false,
    ),
    FAQItem(
      question: "Is my data secure and private?",
      answer: "Yes! We take data privacy seriously:\n• Food images are processed securely\n• Personal health data is encrypted\n• You control what information is stored\n• We comply with privacy regulations\n• You can delete your data anytime",
      isExpanded: false,
    ),
    FAQItem(
      question: "How often should I scan my meals?",
      answer: "For best results:\n• Scan every meal and snack\n• Don't forget beverages\n• Include cooking oils and condiments\n• Be consistent for accurate daily totals\n• Use quick-scan for frequent small items",
      isExpanded: false,
    ),
    FAQItem(
      question: "Can I track water intake?",
      answer: "Yes! Use the hydration tracking feature to:\n• Log water consumption\n• Set daily water goals\n• Get reminders to drink water\n• Track other beverages\n• Monitor hydration patterns",
      isExpanded: false,
    ),
    FAQItem(
      question: "How do I contact support?",
      answer: "For technical issues or questions:\n• Email: support@nutriapp.com\n• In-app chat support\n• Response within 24 hours\n• Include screenshots for scan issues\n• Provide device details for technical problems",
      isExpanded: false,
    ),
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
          child: Scaffold(
            appBar: CustomAppBar(
              title: 'Help Center',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    
                    // Header Section
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.help_outline,
                            size: 64,
                            color: kPrimaryColor,
                          ),
                          16.height,
                          MyText(
                            text: "How can we help you?",
                            size: 24,
                            weight: FontWeight.bold,
                            color: kDynamicText(context),
                          ),
                          8.height,
                          MyText(
                            text: "Find answers to common questions about Nutri AI",
                            size: 16,
                            color: kDynamicText(context)!.withOpacity(0.7),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    32.height,
    
                    // Quick Tips Section
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
                          Row(
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                color: kPrimaryColor,
                                size: 20,
                              ),
                              8.width,
                              MyText(
                                text: "Quick Tips",
                                size: 18,
                                weight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                          12.height,
                          _buildTipItem("💡 Use good lighting for better scan accuracy"),
                          8.height,
                          _buildTipItem("💡 Scan before eating for portion tracking"),
                          8.height,
                          _buildTipItem("💡 Update your goals regularly for better insights"),
                          8.height,
                          _buildTipItem("💡 Contact support for unrecognized foods"),
                        ],
                      ),
                    ),
                    32.height,
    
                    // FAQ Section
                    MyText(
                      text: "Frequently Asked Questions",
                      size: 20,
                      weight: FontWeight.bold,
                      color: kDynamicText(context),
                    ),
                    16.height,
    
                    // FAQ List
                    ..._faqs.map((faq) => _buildFAQItem(faq)).toList(),
    
                    // Contact Support Section
                    40.height,
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kDynamicContainer(context),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: kDynamicBorder(context)!),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.support_agent,
                            size: 48,
                            color: kPrimaryColor,
                          ),
                          16.height,
                          MyText(
                            text: "Still need help?",
                            size: 18,
                            weight: FontWeight.bold,
                            color: kDynamicText(context),
                          ),
                          8.height,
                          MyText(
                            text: "Our support team is here to assist you with any issues or questions",
                            size: 14,
                            color: kDynamicText(context)!.withOpacity(0.7),
                            textAlign: TextAlign.center,
                          ),
                          16.height,
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add contact support action
                                _contactSupport();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: MyText(
                                text: "Contact Support",
                                size: 16,
                                color: Colors.white,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    40.height,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTipItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: text,
          size: 12,
          color: kDynamicText(context),
        ),
      ],
    );
  }

  Widget _buildFAQItem(FAQItem faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: kDynamicIconOnPrimary(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kDynamicBorder(context)!),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: MyText(
          text: faq.question,
          size: 16,
          weight: FontWeight.w600,
          color: kDynamicText(context),
        ),
        trailing: Icon(
          faq.isExpanded ? Icons.expand_less : Icons.expand_more,
          color: kPrimaryColor,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: MyText(
              text: faq.answer,
              size: 14,
              color: kDynamicText(context)!.withOpacity(0.8),
              lineHeight: 1.6,
            ),
          ),
        ],
        onExpansionChanged: (expanded) {
          setState(() {
            faq.isExpanded = expanded;
          });
        },
      ),
    );
  }

  void _contactSupport() {
    // Implement contact support functionality
    //Get.to(() => const ContactSupportScreen()); // You can create this screen
  }
}

class FAQItem {
  final String question;
  final String answer;
  bool isExpanded;

  FAQItem({
    required this.question,
    required this.answer,
    required this.isExpanded,
  });
}