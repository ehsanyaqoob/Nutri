import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/constants/app_colors.dart';
import 'package:nutri/widget/common/my_text_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/export.dart';

class PromoCardModel {
  final String discount;
  final String title;
  final String subtitle;
  final String image;

  PromoCardModel({
    required this.discount,
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

class SwipeablePromoCards extends StatefulWidget {
  final List<PromoCardModel> items;
  final void Function(int index, PromoCardModel item)? onCardTap;

  const SwipeablePromoCards({super.key, required this.items, this.onCardTap});

  @override
  State<SwipeablePromoCards> createState() => _SwipeablePromoCardsState();
}

class _SwipeablePromoCardsState extends State<SwipeablePromoCards>
    with SingleTickerProviderStateMixin {
  final PageController _controller = PageController();
  late AnimationController _tapController;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _tapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final item = widget.items[index];
              return GestureDetector(
                onTapDown: (_) => _tapController.reverse(),
                onTapUp: (_) {
                  _tapController.forward();
                  widget.onCardTap?.call(index, item);
                },
                onTapCancel: () => _tapController.forward(),
                child: ScaleTransition(
                  scale: _tapController,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: kDynamicContainer(context),
                      borderRadius: BorderRadius.circular(26.0),
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey.withOpacity(0.4)
                            : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                     
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                  text: item.discount,
                                  size: 28,
                                  weight: FontWeight.bold,
                                  color: kDynamicText(context),
                                ),
                                const Gap(6),
                                MyText(
                                  text: item.title,
                                  size: 16,
                                  weight: FontWeight.w600,
                                  color: kDynamicText(context),
                                ),
                                const Gap(6),
                                MyText(
                                  text: item.subtitle,
                                  size: 12,
                                  color: kDynamicText(context).withOpacity(0.7),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 🔹 Right Image
                        Image.asset(
                          item.image,
                          height:200,
                          fit: BoxFit.fitHeight,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // 🔹 Page Indicator
          Positioned(
            bottom: 12,
            child: SmoothPageIndicator(
              controller: _controller,
              count: widget.items.length,
              effect: ExpandingDotsEffect(
                dotHeight: 4.0,
                dotWidth: 6.0,
                activeDotColor: kDynamicIcon(context),
                dotColor: kGreyColor4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
