import 'package:nutri/constants/export.dart';

class UserInfoRow extends StatelessWidget {
  final VoidCallback? onAvatarTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onFavoriteTap;

  const UserInfoRow({
    Key? key,
    this.onAvatarTap,
    this.onNotificationTap,
    this.onFavoriteTap,
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
                radius: 30,
                backgroundColor: kDynamicBorder(context),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: kDynamicContainer(context),
                  backgroundImage: controller.profileImage != null
                      ? FileImage(controller.profileImage!)
                      : null,
                  child: controller.profileImage == null
                      ? SvgPicture.asset(
                          Assets.personfilled,
                          height: 28,
                          colorFilter: ColorFilter.mode(
                            kDynamicIcon(context),
                            BlendMode.srcIn,
                          ),
                        )
                      : null,
                ),
              ),
            ),

            const SizedBox(width: 20),

            // Greeting & Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: getGreeting(),
                    size: 14,
                    weight: FontWeight.w600,
                    color: kDynamicText(context).withOpacity(0.7),
                  ),
                  MyText(
                    text: controller.userName,
                    size: 18,
                    weight: FontWeight.bold,
                    color: kDynamicText(context),
                  ),
                ],
              ),
            ),

            // Notifications & Heart Icons
            Row(
              children: [
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
                IconButton(
                  onPressed: onFavoriteTap ?? () {},
                  icon: SvgPicture.asset(
                    Assets.heartunfilled,
                    colorFilter: ColorFilter.mode(
                      kDynamicIcon(context),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}