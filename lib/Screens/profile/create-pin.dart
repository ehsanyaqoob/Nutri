// import 'package:funica/constants/export.dart';
// import 'package:funica/controller/auth-cont.dart';
// import 'package:funica/widget/custom_appbar.dart';

// class CreatePinScreen extends StatefulWidget {
//   const CreatePinScreen({super.key});

//   @override
//   State<CreatePinScreen> createState() => _CreatePinScreenState();
// }

// class _CreatePinScreenState extends State<CreatePinScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final AuthController authController = Get.put(AuthController());

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
//               title: 'Create New Pin',
//               showLeading: true,
//               onBackTap: () => Get.back(),
//             ),
//             backgroundColor: kDynamicScaffoldBackground(context),
//             body: SafeArea(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16.0, vertical: 26.0),
//                 child: Column(
//                   children: [
//                     const Gap(20),
//                     Center(
//                       child: Image.asset(
//                         isDarkMode ? Assets.funicalight : Assets.funicadark,
//                         height: 100,
//                         width: 80,
//                       ),
//                     ),
//                     const Gap(20),
//                     MyText(
//                       text:
//                           "Add a PIN Number to make your account more secure",
//                       textAlign: TextAlign.center,
//                       size: 22,
//                       weight: FontWeight.w600,
//                       color: kDynamicText(context),
//                     ),
//                     Expanded(
//                       child: Center(
//                         child: Pinput(
//                           length: 4,
//                           obscureText: true,
//                           obscuringCharacter: '•',
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           defaultPinTheme: PinTheme(
//                             width: 70,
//                             height: 70,
//                             textStyle: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.w600,
//                               color: kDynamicText(context),
//                               fontFamily: AppFonts.Figtree,
//                             ),
//                             decoration: BoxDecoration(
//                               color: kDynamicBackground(context),
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(color: kDynamicBorder(context)),
//                             ),
//                           ),
//                           focusedPinTheme: PinTheme(
//                             width: 70,
//                             height: 70,
//                             textStyle: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.w700,
//                               color: kDynamicText(context),
//                               fontFamily: AppFonts.Figtree,
//                             ),
//                             decoration: BoxDecoration(
//                               color: kDynamicScaffoldBackground(context),
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(color: kSecondaryColor, width: 1.5),
//                             ),
//                           ),
//                           submittedPinTheme: PinTheme(
//                             width: 70,
//                             height: 70,
//                             textStyle: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.w600,
//                               color: kDynamicText(context),
//                               fontFamily: AppFonts.Figtree,
//                             ),
//                             decoration: BoxDecoration(
//                               color: kDynamicBackground(context),
//                               borderRadius: BorderRadius.circular(20),
//                               border:
//                                   Border.all(color: kDynamicBorder(context), width: 1.5),
//                             ),
//                           ),
//                           onChanged: (value) => authController.pin.value = value,
//                           onCompleted: (value) => authController.pin.value = value,
//                         ),
//                       ),
//                     ),
//                     const Gap(40),
//                     Obx(() {
//                       return MyButton(
//                         buttonText: "Continue",
//                         isLoading: authController.isPinLoading.value,
//                         onTap: authController.createPin,
//                       );
//                     }),
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
