import 'package:nutri/constants/export.dart';

class UserInfoRow extends StatelessWidget {
  final VoidCallback? onAvatarTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onBookmarkTap;

  const UserInfoRow({
    Key? key,
    this.onAvatarTap,
    this.onNotificationTap,
    this.onBookmarkTap,
  }) : super(key: key);

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning 👋';
    } else if (hour < 17) {
      return 'Good Afternoon 👋';
    } else {
      return 'Good Evening 👋';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    return GetBuilder<ProfileController>(
      builder: (_) {
        return Row(
          children: [
            // Avatar
            Bounce(
              onTap: onAvatarTap ?? () {},
              child: CircleAvatar(
                radius: 24,
                backgroundColor: kDynamicBorder(context),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: kDynamicContainer(context),
                  backgroundImage: controller.profileImage != null
                      ? FileImage(controller.profileImage!)
                      : null,
                  child: controller.profileImage == null
                      ? SvgPicture.asset(
                          Assets.personfilled,
                          height: 22,
                          colorFilter: ColorFilter.mode(
                            kDynamicIcon(context),
                            BlendMode.srcIn,
                          ),
                        )
                      : null,
                ),
              ),
            ),
           Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: getGreeting(),
                    size: 12.0,
                    weight: FontWeight.w600,
                    color: kDynamicText(context).withOpacity(0.7),
                  ),
                  MyText(
                    text: controller.userName,
                    size: 14.0,
                    weight: FontWeight.bold,
                    color: kDynamicText(context),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onNotificationTap ?? () {},
              icon: SvgPicture.asset(
                Assets.notificationunfilled,
                colorFilter: ColorFilter.mode(
                  kDynamicIcon(context),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}