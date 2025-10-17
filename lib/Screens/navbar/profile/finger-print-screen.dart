// import 'dart:math';
// import 'package:bounce/bounce.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:funica/constants/export.dart';
// import 'package:funica/widget/custom_appbar.dart';
// import 'package:get/get.dart';

// class FingerPrintScreen extends StatefulWidget {
//   const FingerPrintScreen({super.key});

//   @override
//   State<FingerPrintScreen> createState() => _FingerPrintScreenState();
// }

// class _FingerPrintScreenState extends State<FingerPrintScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _opacityAnimation;
//   bool _isScanning = false;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     )..repeat(reverse: true);

//     _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );

//     _opacityAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _startScan() {
//     setState(() => _isScanning = true);
//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted) {
//         setState(() => _isScanning = false);
//         _showSuccessDialog();
//       }
//     });
//   }

//   void _showSuccessDialog() {
//     Get.dialog(
//       Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             SizedBox(
//               width: 200,
//               height: 200,
//               child: TweenAnimationBuilder<double>(
//                 tween: Tween(begin: 0, end: 1),
//                 duration: const Duration(seconds: 1),
//                 builder: (context, value, child) {
//                   return CustomPaint(
//                     painter: _SparklePainter(
//                       animationValue: value,
//                       color: kDynamicPrimary(context),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: kDynamicScaffoldBackground(context),
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: kDynamicPrimary(context).withOpacity(0.3),
//                         blurRadius: 15,
//                         spreadRadius: 3,
//                       ),
//                     ],
//                   ),
//                   child: Icon(
//                     Icons.fingerprint,
//                     size: 80,
//                     color: kDynamicPrimary(context),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 MyText(
//                   text: "Congratulations!".tr,
//                   size: 20,
//                   weight: FontWeight.w700,
//                   color: kDynamicText(context),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 10),
//                 MyText(
//                   text: "Your account is ready to use.".tr,
//                   size: 14,
//                   color: kSubText,
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 20),
//                 MyButton(
//                   buttonText: "Continue".tr,
//                   onTap: () => Get.back(),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       barrierDismissible: false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ThemeController>(
//       builder: (themeController) {
//         final bool isDarkMode = themeController.isDarkMode;
//         return AnnotatedRegion<SystemUiOverlayStyle>(
//           value: SystemUiOverlayStyle(
//             statusBarColor: Colors.transparent,
//             statusBarIconBrightness:
//                 isDarkMode ? Brightness.light : Brightness.dark,
//             systemNavigationBarColor: kDynamicScaffoldBackground(context),
//             systemNavigationBarIconBrightness:
//                 isDarkMode ? Brightness.light : Brightness.dark,
//           ),
//           child: Scaffold(
//             appBar: CustomAppBar(
//               title: "Fingerprint ID".tr,
//               onBackTap: () => Get.back(),
//               showLeading: true,
//             ),
//             backgroundColor: kDynamicScaffoldBackground(context),
//             body: SafeArea(
//               child: Padding(
//                 padding: AppSizes.DEFAULT,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     MyText(
//                       text:
//                           "Place finger on the sensor to confirm your identity."
//                               .tr,
//                       size: 22,
//                       textAlign: TextAlign.center,
//                       weight: FontWeight.w600,
//                       color: kDynamicText(context).withOpacity(0.7),
//                     ),
//                     const Spacer(),
//                     Expanded(
//                       child: Center(
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             if (_isScanning)
//                               AnimatedBuilder(
//                                 animation: _animationController,
//                                 builder: (context, child) {
//                                   return Container(
//                                     width: 200,
//                                     height: 200,
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       gradient: RadialGradient(
//                                         colors: [
//                                           kDynamicPrimary(context)
//                                               .withOpacity(0.2),
//                                           kDynamicPrimary(context)
//                                               .withOpacity(0.1),
//                                           Colors.transparent,
//                                         ],
//                                         stops: const [0.1, 0.3, 1.0],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             AnimatedBuilder(
//                               animation: _animationController,
//                               builder: (context, child) {
//                                 return Transform.scale(
//                                   scale: _scaleAnimation.value,
//                                   child: Opacity(
//                                     opacity: _opacityAnimation.value,
//                                     child: Bounce(
//                                       onTap: _isScanning ? null : _startScan,
//                                       child: Icon(
//                                         Icons.fingerprint,
//                                         size: 120,
//                                         color: _isScanning
//                                             ? kDynamicPrimary(context)
//                                             : kDynamicIcon(context)
//                                                 .withOpacity(0.7),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const Spacer(),
//                     AnimatedOpacity(
//                       opacity: _isScanning ? 0.7 : 1.0,
//                       duration: const Duration(milliseconds: 300),
//                       child: MyText(
//                         text: _isScanning
//                             ? "Scanning...".tr
//                             : "Touch the sensor to authenticate".tr,
//                         size: 16,
//                         textAlign: TextAlign.center,
//                         weight: FontWeight.w500,
//                         color: kDynamicText(context).withOpacity(0.8),
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     MyButton(
//                       buttonText: _isScanning
//                           ? "Authenticating...".tr
//                           : "Start Authentication".tr,
//                       isLoading: _isScanning,
//                       onTap: _isScanning ? null : _startScan,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _SparklePainter extends CustomPainter {
//   final double animationValue;
//   final Color color;

//   _SparklePainter({required this.animationValue, required this.color});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint =
//         Paint()..color = color.withOpacity(0.3 + 0.7 * (1 - animationValue));
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2 * animationValue;

//     for (int i = 0; i < 10; i++) {
//       final angle = (i * 36.0 + animationValue * 360) * pi / 180;
//       final dx = center.dx + radius * 0.7 * cos(angle);
//       final dy = center.dy + radius * 0.7 * sin(angle);
//       canvas.drawCircle(Offset(dx, dy), 5, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant _SparklePainter oldDelegate) => true;
// }
