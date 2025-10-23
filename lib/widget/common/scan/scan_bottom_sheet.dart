import 'package:nutri/constants/export.dart';

class ScanBottomSheet extends StatelessWidget {
  const ScanBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      (
        index: 1,
        icon: Assets.scanfilled,
        title: 'Scan Food',
        subtitle: 'Snap and analyze instantly',
        color: kDynamicPrimary(context),
        route: AppLinks.scannscreen
      ),
      (
        index: 2,
        icon: Assets.mealfilled,
        title: 'Day Meal',
        subtitle: 'Add your complete plan',
        color: kDynamicSystemGreen(context),
        route: AppLinks.daymealsscreen
      ),
      (
        index: 3,
        icon: Assets.ai,
        title: 'AI Insight',
        subtitle: 'Get smart nutrition advice',
        color: kDynamicSystemBlue(context),
        route: AppLinks.chataiscreen
      ),
    ];

    return SafeArea(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.9, end: 1),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        builder: (context, value, child) => Transform.scale(
          scale: value,
          child: Container(
            margin: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
            decoration: BoxDecoration(
              color: kDynamicModalBackground(context),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: kDynamicShadow(context).withOpacity(0.25),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyText(
                    text: 'To close this drag it towards bottom ',
                    size: 17,
                    weight: FontWeight.w600,
                    color: kDynamicTitleText(context),
                  ),
                  10.height,
                  ...options.map(
                    (opt) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _buildOption(
                        opt.index,
                        opt.icon,
                        opt.title,
                        opt.subtitle,
                        opt.color,
                        () {
                          Navigator.of(context).pop();
                          NavigationHelper.navigateTo(
                            opt.route,
                            customTransition: Transition.fadeIn,
                            customDuration:
                                const Duration(milliseconds: 500),
                          );
                        },
                        context,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOption(
    int index,
    String iconAsset,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
    BuildContext context,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Row(
        children: [
          // Index number
          MyText(
            text: 
            '$index.',
              size: 16,
              weight: FontWeight.w600,
              color: kDynamicSubtitleText(context),
          
          ),
          const SizedBox(width: 12),

          // Icon
          SvgPicture.asset(
            iconAsset,
            color: color,
            height: 26,
            width: 26,
          ),
          const SizedBox(width: 18),

          // Title & subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: title,
                  size: 17,
                  weight: FontWeight.w600,
                  color: kDynamicTitleText(context),
                ),
                if (subtitle.isNotEmpty)
                  MyText(
                    text: subtitle,
                    size: 14,
                    color: kDynamicSubtitleText(context),
                  ),
              ],
            ),
          ),

          // Arrow
          SvgPicture.asset(
            Assets.arrowforward,
            color: kDynamicSubtitleText(context).withOpacity(0.6),
            height: 26.0,
          ),
        ],
      ),
    );
  }
}
