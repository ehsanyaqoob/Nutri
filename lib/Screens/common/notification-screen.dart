import 'package:nutri/constants/export.dart';
import 'package:nutri/widget/common/toasts.dart';


class NotificationModel {
  final String type; // e.g., like, message, update
  final String icon;
  final String title;
  final String subtitle;

  NotificationModel({
    required this.type,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<NotificationModel> today = [
      NotificationModel(
        type: "update",
        icon: Assets.notificationunfilled,
        title: "App Maintenance".tr,
        subtitle: "Scheduled at 9:00 PM tonight",
      ),
    ];

    final List<NotificationModel> yesterday = [
      NotificationModel(
        type: "like",
        icon: Assets.heartunfilled,
        title: "New Like".tr,
        subtitle: "Sarah liked your comment",
      ),
      NotificationModel(
        type: "message",
        icon: Assets.smsfilled,
        title: "Message Received".tr,
        subtitle: "You got 1 new message",
      ),
    ];

    final List<NotificationModel> previous = [
      NotificationModel(
        type: "update",
        icon: Assets.notificationunfilled,
        title: "New Update Available".tr,
        subtitle: "Version 2.0.1 is ready to install",
      ),
      NotificationModel(
        type: "follow",
        icon: Assets.heartunfilled,
        title: "New Follow".tr,
        subtitle: "James started following you",
      ),
      NotificationModel(
        type: "verification",
        icon: Assets.smsfilled,
        title: "Verification".tr,
        subtitle: "Your phone number was verified",
      ),
    ];

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
            backgroundColor: kDynamicScaffoldBackground(context),
          appBar: CustomAppBar(
            showNotificationIcon: true,
            showLeading: true,
            onBackTap: () => Get.back(),
            title: 'Notification',
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: AppSizes.DEFAULT,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(context, "Today", today),
                  _buildSection(context, "Yesterday", yesterday),
                  _buildSection(context, "Previous", previous),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<NotificationModel> notifications,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: title,
          size: 22,
          weight: FontWeight.bold,
          color: kDynamicText(context),
        ),
        const Gap(10),
        ...notifications.map(
          (n) => InfoListTile(
            icon: n.icon,
            title: n.title,
            subtitle: n.subtitle,
            onTap: () => _handleNotificationTap(context, n),
          ),
        ),
        const Gap(20),
      ],
    );
  }

  void _handleNotificationTap(BuildContext context, NotificationModel n) {
    switch (n.type) {
      case "like":
        AppToast.info("Like, ${n.subtitle}");
        break;
      case "message":
        Get.to(() => const DummyDetailPage(title: "Chat Screen"));
        break;
      case "update":
        Get.to(() => const DummyDetailPage(title: "App Update Details"));
        break;
      case "follow":
        AppToast.info("Follow, ${n.subtitle}");
        break;
      case "verification":
        AppToast.info("Verified, ✔ ${n.subtitle}");
        break;
      default:
        AppToast.info("Notification,  ${n.title}");
    }
  }
}

// 🔹 Reusable List Tile
class InfoListTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const InfoListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onTap ?? () {},
      child: Container(
        height: 100,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: kDynamicBackground(context),
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: kDynamicBorder(context),
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor:  kDynamicBorder(context),
              child: SvgPicture.asset(
                icon,
                color: kDynamicIcon(context),
                height: 26,
              ),
            ),
            const Gap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    text: title,
                    size: 18.0,
                    weight: FontWeight.bold,
                    color: kDynamicText(context),
                  ),
                  const Gap(6),
                  MyText(
                    text: subtitle,
                    size: 14.0,
                    weight: FontWeight.w500,
                    color: kDynamicText(context).withOpacity(0.7),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Dummy Detail Page Example (for navigation)
class DummyDetailPage extends StatelessWidget {
  final String title;
  const DummyDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDynamicScaffoldBackground(context),
      appBar: AppBar(
        backgroundColor: kDynamicScaffoldBackground(context),
        title: Text(title),
      ),
      body: Center(
        child: MyText(
          text: "Details about $title",
          size: 18,
          weight: FontWeight.w600,
          color: kDynamicText(context),
        ),
      ),
    );
  }
}
