// import 'package:nutri/constants/export.dart';

// class BottomSheetHelper {


  
//   // Payment Processing Sheet - Enhanced Version
//   static void showPaymentProcessingSheet({
//     required List<CartItem> cartItems,
//     required double totalAmount,
//     required String selectedAddress,
//     required ShippingOption selectedShipping,
//     required PromoCode? appliedPromo,
//     required double discountAmount,
//     required String selectedPaymentMethod,
//     required Function() onPaymentSuccess,
//   }) {
//     try {
//       final double finalTotal =
//           totalAmount + selectedShipping.price - discountAmount;

//       // Create order details for display
//       final orderNumber = "ORD-${DateTime.now().millisecondsSinceEpoch}";
//       final orderDate = DateTime.now();
//       final estimatedDelivery = DateTime.now().add(const Duration(days: 3));

//       // Show loading first
//       Get.dialog(
//         AlertDialog(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           insetPadding: const EdgeInsets.all(20),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   color: kDynamicCard(Get.context!),
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     FunicaLoader(),
//                     const Gap(16),
//                     MyText(
//                       text: "Processing Payment...",
//                       size: 16,
//                       weight: FontWeight.w600,
//                       color: kDynamicText(Get.context!),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         barrierDismissible: false,
//       );

//       // After 3 seconds, show the success sheet
//       Future.delayed(const Duration(seconds: 3), () {
//         if (Get.isDialogOpen ?? false) {
//           Get.back(); // Close loading dialog
//         }

//         _showSuccessSheet(
//           cartItems: cartItems,
//           totalAmount: totalAmount,
//           selectedAddress: selectedAddress,
//           selectedShipping: selectedShipping,
//           appliedPromo: appliedPromo,
//           discountAmount: discountAmount,
//           selectedPaymentMethod: selectedPaymentMethod,
//           finalTotal: finalTotal,
//           orderNumber: orderNumber,
//           orderDate: orderDate,
//           estimatedDelivery: estimatedDelivery,
//           onPaymentSuccess: onPaymentSuccess,
//         );
//       });
//     } catch (e) {
//       print('Error in payment processing: $e');
//       // Fallback: Just navigate to success
//       onPaymentSuccess();
//     }
//   }

//   static void _showSuccessSheet({
//     required List<CartItem> cartItems,
//     required double totalAmount,
//     required String selectedAddress,
//     required ShippingOption selectedShipping,
//     required PromoCode? appliedPromo,
//     required double discountAmount,
//     required String selectedPaymentMethod,
//     required double finalTotal,
//     required String orderNumber,
//     required DateTime orderDate,
//     required DateTime estimatedDelivery,
//     required Function() onPaymentSuccess,
//   }) {
//     try {
//       // Create initial status history
//       final statusHistory = [
//         OrderStatusUpdate(
//           status: OrderStatus.pending,
//           timestamp: orderDate,
//           note: 'Order placed successfully',
//         ),
//         OrderStatusUpdate(
//           status: OrderStatus.confirmed,
//           timestamp: DateTime.now(),
//           note:
//               'Payment confirmed via ${_getPaymentMethodName(selectedPaymentMethod)}',
//         ),
//       ];

//       // Create and save order immediately
//       final newOrder = Order(
//         orderNumber: orderNumber,
//         orderDate: orderDate,
//         items: cartItems,
//         totalAmount: finalTotal,
//         shippingAddress: selectedAddress,
//         paymentMethod: selectedPaymentMethod,
//         status: OrderStatus.confirmed,
//         estimatedDelivery: estimatedDelivery,
//         statusHistory: statusHistory,
//       );

//       // Save to orders controller
//       final orderController = Get.find<OrderController>();
//       orderController.addNewOrder(newOrder);

//       // Clear cart
//       final productController = Get.find<ProductController>();
//       productController.clearCart();

//       Get.bottomSheet(
//         Container(
//           height: Get.height * 0.75, // Increased height for more content
//           decoration: BoxDecoration(
//             color: kDynamicCard(Get.context!),
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(32.0),
//               topRight: Radius.circular(32.0),
//             ),
//           ),
//           child: Column(
//             children: [
//               // Draggable handle - centered
//               Center(
//                 child: Container(
//                   margin: const EdgeInsets.only(top: 12, bottom: 8),
//                   width: 60,
//                   height: 5,
//                   decoration: BoxDecoration(
//                     color: kDynamicListTileSubtitle(
//                       Get.context!,
//                     )!.withOpacity(0.4),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//               ),

//               // Header with close button
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20,
//                   vertical: 8,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     MyText(
//                       text: "Order Confirmed!",
//                       size: 22,
//                       weight: FontWeight.w700,
//                       color: kDynamicText(Get.context!),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         _safeCloseSheetAndNavigateToOrders(onPaymentSuccess);
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: kDynamicScaffoldBackground(Get.context!),
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: SvgPicture.asset(
//                           Assets.close,
//                           height: 20,
//                           color: kDynamicIcon(Get.context!),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const Gap(8),

//               Expanded(
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Success Message
//                         Container(
//                           padding: const EdgeInsets.all(18),
//                           decoration: BoxDecoration(
//                             color: kDynamicSystemGreen(
//                               Get.context!,
//                             )!.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                               color: kDynamicSystemGreen(
//                                 Get.context!,
//                               )!.withOpacity(0.3),
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   color: kDynamicSystemGreen(Get.context!),
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 child: SvgPicture.asset(
//                                   Assets.check,
//                                   height: 20,
//                                   color: kDynamicIcon(Get.context!),
//                                 ),
//                               ),
//                               const Gap(14),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     MyText(
//                                       text: "Payment Successful!",
//                                       size: 16,
//                                       weight: FontWeight.w700,
//                                       color: kDynamicSystemGreen(Get.context!),
//                                     ),
//                                     const Gap(4),
//                                     MyText(
//                                       text:
//                                           "Your order #$orderNumber has been confirmed",
//                                       size: 13,
//                                       color: kDynamicSystemGreen(Get.context!),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         const Gap(24),

//                         // Order Summary Card
//                         Container(
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             color: kDynamicScaffoldBackground(Get.context!),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                               color: kDynamicBorder(Get.context!),
//                               width: 1.2,
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               MyText(
//                                 text: "Order Summary",
//                                 size: 18,
//                                 weight: FontWeight.w700,
//                                 color: kDynamicText(Get.context!),
//                               ),
//                               const Gap(16),

//                               // Order Items Preview
//                               ...cartItems
//                                   .take(2)
//                                   .map(
//                                     (item) => Padding(
//                                       padding: const EdgeInsets.only(
//                                         bottom: 12,
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           CommonImageView(
//                                             url: item.product.image,
//                                             height: 50,
//                                             width: 50,
//                                             radius: 8,
//                                             fit: BoxFit.fill,
//                                           ),
//                                           const Gap(12),
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 MyText(
//                                                   text: item.product.title,
//                                                   size: 14,
//                                                   weight: FontWeight.w500,
//                                                   color: kDynamicText(
//                                                     Get.context!,
//                                                   ),
//                                                   maxLines: 1,
//                                                   textOverflow:
//                                                       TextOverflow.ellipsis,
//                                                 ),
//                                                 const Gap(4),
//                                                 MyText(
//                                                   text:
//                                                       "Qty: ${item.quantity} • \$${item.totalPrice.toStringAsFixed(2)}",
//                                                   size: 12,
//                                                   color:
//                                                       kDynamicListTileSubtitle(
//                                                         Get.context!,
//                                                       ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),

//                               if (cartItems.length > 2) ...[
//                                 const Gap(8),
//                                 MyText(
//                                   text: "+ ${cartItems.length - 2} more items",
//                                   size: 12,
//                                   color: kDynamicListTileSubtitle(Get.context!),
//                                 ),
//                               ],

//                               const Gap(16),
//                               Divider(
//                                 color: kDynamicBorder(Get.context!)!,
//                                 height: 1,
//                               ),
//                               const Gap(16),

//                               // Price Breakdown
//                               _buildPriceRow(
//                                 "Subtotal",
//                                 "\$${totalAmount.toStringAsFixed(2)}",
//                               ),
//                               const Gap(8),
//                               _buildPriceRow(
//                                 "Shipping",
//                                 "\$${selectedShipping.price.toStringAsFixed(2)}",
//                               ),
//                               if (appliedPromo != null) ...[
//                                 const Gap(8),
//                                 _buildPriceRow(
//                                   "Discount (${appliedPromo.code})",
//                                   "-\$${discountAmount.toStringAsFixed(2)}",
//                                   isDiscount: true,
//                                 ),
//                               ],
//                               const Gap(12),
//                               Divider(
//                                 color: kDynamicBorder(Get.context!)!,
//                                 height: 1,
//                               ),
//                               const Gap(12),
//                               _buildTotalRow(
//                                 "Total Amount",
//                                 "\$${finalTotal.toStringAsFixed(2)}",
//                               ),
//                             ],
//                           ),
//                         ),

//                         const Gap(20),

//                         // Order Details Card
//                         Container(
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             color: kDynamicScaffoldBackground(Get.context!),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                               color: kDynamicBorder(Get.context!),
//                               width: 1.2,
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               MyText(
//                                 text: "Order Details",
//                                 size: 18,
//                                 weight: FontWeight.w700,
//                                 color: kDynamicText(Get.context!),
//                               ),
//                               const Gap(16),

//                               // Order Information
//                               _buildDetailRow("Order Number", orderNumber),
//                               const Gap(8),
//                               _buildDetailRow(
//                                 "Order Date",
//                                 "${orderDate.day}/${orderDate.month}/${orderDate.year} ${orderDate.hour}:${orderDate.minute.toString().padLeft(2, '0')}",
//                               ),
//                               const Gap(8),
//                               _buildDetailRow(
//                                 "Estimated Delivery",
//                                 "${estimatedDelivery.day}/${estimatedDelivery.month}/${estimatedDelivery.year}",
//                               ),
//                               const Gap(8),
//                               _buildDetailRow(
//                                 "Total Items",
//                                 "${cartItems.length}",
//                               ),

//                               const Gap(16),
//                               Divider(
//                                 color: kDynamicBorder(Get.context!)!,
//                                 height: 1,
//                               ),
//                               const Gap(16),

//                               // Shipping & Payment
//                               _buildDetailRowWithIcon(
//                                 "Shipping Method",
//                                 "${selectedShipping.title} • \$${selectedShipping.price.toStringAsFixed(2)}",
//                                 Assets.tracking,
//                               ),
//                               const Gap(12),
//                               _buildDetailRowWithIcon(
//                                 "Payment Method",
//                                 _getPaymentMethodName(selectedPaymentMethod),
//                                 _getPaymentMethodIcon(selectedPaymentMethod),
//                               ),
//                               const Gap(12),
//                               _buildDetailRowWithIcon(
//                                 "Delivery Address",
//                                 selectedAddress,
//                                 Assets.loaction,
//                               ),
//                             ],
//                           ),
//                         ),

//                         const Gap(20),

//                         // Next Steps Card
//                         Container(
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             color: kDynamicPrimary(
//                               Get.context!,
//                             )!.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(
//                               color: kDynamicPrimary(
//                                 Get.context!,
//                               )!.withOpacity(0.3),
//                             ),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(8),
//                                     decoration: BoxDecoration(
//                                       color: kDynamicContainer(Get.context!),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: SvgPicture.asset(
//                                       Assets.info,
//                                       height: 20,
//                                       color: kDynamicIcon(Get.context!),
//                                     ),
//                                   ),
//                                   const Gap(12),
//                                   Expanded(
//                                     child: MyText(
//                                       text: "What's Next?",
//                                       size: 16,
//                                       weight: FontWeight.w700,
//                                       color: kDynamicPrimary(Get.context!),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const Gap(12),
//                               _buildNextStep(
//                                 "1. Order Processing",
//                                 "We'll start preparing your items within 24 hours",
//                               ),
//                               const Gap(8),
//                               _buildNextStep(
//                                 "2. Shipping Updates",
//                                 "Track your order in real-time from the Orders tab",
//                               ),
//                               const Gap(8),
//                               _buildNextStep(
//                                 "3. Delivery",
//                                 "Expected delivery: ${estimatedDelivery.day}/${estimatedDelivery.month}/${estimatedDelivery.year}",
//                               ),
//                             ],
//                           ),
//                         ),

//                         const Gap(24),

//                         // Track Order Button
//                         MyButtonWithIcon(
//                           iconPath: Assets.info,
//                           text: "Track Your Order",
//                           onTap: () {
//                             _safeCloseSheetAndNavigateToOrders(
//                               onPaymentSuccess,
//                             );
//                           },
//                         ),

//                         const Gap(32),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         isScrollControlled: true,
//         backgroundColor: Colors.transparent,
//         enableDrag: true,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(32.0),
//             topRight: Radius.circular(32.0),
//           ),
//         ),
//       );
//     } catch (e) {
//       print('Error showing success sheet: $e');
//       // Fallback: Close any open dialogs and navigate
//       if (Get.isBottomSheetOpen ?? false) Get.back();
//       onPaymentSuccess();
//     }
//   }

//   // Enhanced helper method for safe sheet closing and navigation
//   static void _safeCloseSheetAndNavigateToOrders(Function() onSuccess) {
//     try {
//       if (Get.isBottomSheetOpen ?? false) {
//         Get.back();
//       }

//       // Navigate to navbar and switch to orders tab
//       Get.offAll(
//         () => FunicaNavBar(),
//         transition: Transition.cupertino,
//         duration: const Duration(milliseconds: 500),
//       );

//       // Switch to orders tab (index 3)
//       Future.delayed(const Duration(milliseconds: 300), () {
//         try {
//           final navController = Get.find<NavController>();
//           navController.changeIndex(3);
//           AppToast.success(
//             "Order placed successfully! Track your order in the Active tab.",
//           );
//         } catch (e) {
//           print('Error switching to orders tab: $e');
//         }
//       });

//       onSuccess();
//     } catch (e) {
//       print('Error closing sheet: $e');
//       // Final fallback
//       Get.offAll(() => FunicaNavBar());
//     }
//   }

//   // New helper method for next steps
//   static Widget _buildNextStep(String step, String description) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: 6,
//           height: 6,
//           margin: const EdgeInsets.only(top: 8, right: 12),
//           decoration: BoxDecoration(
//             color: kDynamicPrimary(Get.context!),
//             shape: BoxShape.circle,
//           ),
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               MyText(
//                 text: step,
//                 size: 14,
//                 weight: FontWeight.w600,
//                 color: kDynamicText(Get.context!),
//               ),
//               const Gap(2),
//               MyText(
//                 text: description,
//                 size: 12,
//                 color: kDynamicListTileSubtitle(Get.context!),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // Enhanced detail row with icon
//   static Widget _buildDetailRowWithIcon(
//     String label,
//     String value,
//     String iconPath,
//   ) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(6),
//           decoration: BoxDecoration(
//             color: kDynamicPrimary(Get.context!)!.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: SvgPicture.asset(
//             iconPath,
//             height: 16,
//             color: kDynamicPrimary(Get.context!),
//           ),
//         ),
//         const Gap(12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               MyText(
//                 text: label,
//                 size: 12,
//                 color: kDynamicListTileSubtitle(Get.context!),
//               ),
//               const Gap(2),
//               MyText(
//                 text: value,
//                 size: 14,
//                 weight: FontWeight.w600,
//                 color: kDynamicText(Get.context!),
//                 maxLines: 2,
//                 textOverflow: TextOverflow.ellipsis,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // Enhanced detail row
//   static Widget _buildDetailRow(String label, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         MyText(
//           text: label,
//           size: 14,
//           color: kDynamicListTileSubtitle(Get.context!),
//         ),
//         Flexible(
//           child: MyText(
//             text: value,
//             size: 14,
//             weight: FontWeight.w600,
//             color: kDynamicText(Get.context!),
//             textAlign: TextAlign.right,
//           ),
//         ),
//       ],
//     );
//   }

//   // Enhanced price row
//   static Widget _buildPriceRow(
//     String label,
//     String value, {
//     bool isDiscount = false,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         MyText(
//           text: label,
//           size: 14,
//           color: isDiscount
//               ? kDynamicSystemGreen(Get.context!)
//               : kDynamicListTileSubtitle(Get.context!),
//         ),
//         MyText(
//           text: value,
//           size: 14,
//           color: isDiscount
//               ? kDynamicSystemGreen(Get.context!)
//               : kDynamicText(Get.context!),
//           weight: isDiscount ? FontWeight.w600 : FontWeight.normal,
//         ),
//       ],
//     );
//   }

//   // Total row
//   static Widget _buildTotalRow(String label, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         MyText(
//           text: label,
//           size: 16,
//           weight: FontWeight.w700,
//           color: kDynamicText(Get.context!),
//         ),
//         MyText(
//           text: value,
//           size: 18,
//           weight: FontWeight.w700,
//           color: kDynamicPrimary(Get.context!),
//         ),
//       ],
//     );
//   }

//   // Payment method icons and names (keep existing)
//   static String _getPaymentMethodIcon(String methodId) {
//     switch (methodId) {
//       case "wallet":
//         return Assets.walletfilled;
//       case "paypal":
//         return Assets.paypal;
//       case "google_pay":
//         return Assets.google;
//       case "apple_pay":
//         return Assets.apple;
//       case "stripe":
//         return Assets.walletfilled;
//       case "amazon_pay":
//         return Assets.amazon;
//       default:
//         return Assets.walletfilled;
//     }
//   }

//   static String _getPaymentMethodName(String methodId) {
//     switch (methodId) {
//       case "wallet":
//         return "My Wallet";
//       case "paypal":
//         return "PayPal";
//       case "google_pay":
//         return "Google Pay";
//       case "apple_pay":
//         return "Apple Pay";
//       case "stripe":
//         return "Credit/Debit Card";
//       case "amazon_pay":
//         return "Amazon Pay";
//       default:
//         return "My Wallet";
//     }
//   }

//   // Generic confirmation bottom sheet for removing items with item preview
//   static void showRemoveItemSheet({
//     required String title,
//     required String message,
//     required CartItem cartItem, // Add cartItem parameter
//     required VoidCallback onConfirm,
//     String confirmText = "Remove",
//     String cancelText = "Cancel",
//   }) {
//     Get.bottomSheet(
//       Container(
//         decoration: BoxDecoration(
//           color: kDynamicCard(Get.context!),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(26.0),
//             topRight: Radius.circular(26.0),
//           ),
//         ),
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Container(
//                 width: 66,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: kDynamicListTileSubtitle(Get.context!),
//                   borderRadius: BorderRadius.circular(6.0),
//                 ),
//               ),
//             ),
//             const Gap(20),
//             Align(
//               alignment: Alignment.center,
//               child: MyText(
//                 text: title,
//                 size: 24.0,
//                 weight: FontWeight.w600,
//                 color: kDynamicText(Get.context!),
//               ),
//             ),
//             const Gap(12),

//             // Item Preview Card
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: kDynamicScaffoldBackground(Get.context!),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: kDynamicBorder(Get.context!)),
//               ),
//               child: Row(
//                 children: [
//                   // Product Image
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 12.0),
//                     padding: const EdgeInsets.all(12.0),
//                     decoration: BoxDecoration(
//                       color: kDynamicCard(Get.context!),
//                       borderRadius: BorderRadius.circular(16.0),
//                       border: Border.all(
//                         color: kDynamicBorder(Get.context!),
//                         width: 1.2,
//                       ),
//                     ),
//                     child: CommonImageView(
//                       url: cartItem.product.image,
//                       height: 70.0,
//                       width: 70.0,
//                       radius: 12.0,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   const Gap(12),

//                   // Product Details
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         MyText(
//                           text: cartItem.product.title,
//                           size: 14,
//                           weight: FontWeight.w600,
//                           color: kDynamicText(Get.context!),
//                           maxLines: 1,
//                           textOverflow: TextOverflow.ellipsis,
//                         ),
//                         const Gap(4),
//                         MyText(
//                           text: "Quantity: ${cartItem.quantity}",
//                           size: 12,
//                           color: kDynamicListTileSubtitle(Get.context!),
//                         ),
//                         const Gap(2),
//                         MyText(
//                           text:
//                               "Total: \$${cartItem.totalPrice.toStringAsFixed(2)}",
//                           size: 12,
//                           weight: FontWeight.w600,
//                           color: kDynamicPrimary(Get.context!),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const Gap(16),
//             MyText(
//               text: message,
//               size: 14,
//               color: kDynamicListTileSubtitle(Get.context!),
//             ),
//             const Gap(24),
//             Row(
//               children: [
//                 // Cancel Button
//                 Expanded(
//                   child: MyButton(
//                     buttonText: cancelText,
//                     onTap: () => Get.back(),
//                     backgroundColor: kDynamicScaffoldBackground(Get.context!),
//                     fontColor: kDynamicText(Get.context!),
//                     outlineColor: kDynamicBorder(Get.context!),
//                   ),
//                 ),
//                 const Gap(12),
//                 // Confirm Button
//                 Expanded(
//                   child: MyButton(
//                     buttonText: confirmText,
//                     onTap: () {
//                       Get.back();
//                       onConfirm();
//                     },
//                     backgroundColor: Colors.red,
//                     fontColor: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//             const Gap(10),
//           ],
//         ),
//       ),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//     );
//   }

//   // Updated specific cart item removal bottom sheet
//   static void showRemoveCartItemSheet({
//     required CartItem cartItem,
//     required ProductController productController,
//   }) {
//     showRemoveItemSheet(
//       title: "Remove Item ?",
//       message: "Are you sure you want to remove this item from your cart?",
//       cartItem: cartItem, // Pass the cartItem
//       onConfirm: () => productController.removeFromCart(cartItem),
//       confirmText: "Remove",
//     );
//   }

//   // Updated clear cart bottom sheet with multiple items preview
//   static void showClearCartSheet({
//     required ProductController productController,
//   }) {
//     final cartItems = productController.cartItems;

//     Get.bottomSheet(
//       Container(
//         decoration: BoxDecoration(
//           color: kDynamicCard(Get.context!),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(26.0),
//             topRight: Radius.circular(26.0),
//           ),
//         ),
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Container(
//                 width: 66,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: kDynamicListTileSubtitle(Get.context!),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),
//             ),
//             const Gap(20),
//             MyText(
//               text: "Clear Cart",
//               size: 18,
//               weight: FontWeight.w600,
//               color: kDynamicText(Get.context!),
//             ),
//             const Gap(12),

//             // Cart Summary
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: kDynamicScaffoldBackground(Get.context!),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: kDynamicBorder(Get.context!)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   MyText(
//                     text:
//                         "You're about to remove ${cartItems.length} items from your cart:",
//                     size: 14,
//                     color: kDynamicListTileSubtitle(Get.context!),
//                   ),
//                   const Gap(8),

//                   // Limited items preview (show first 3 items)
//                   ...cartItems
//                       .take(3)
//                       .map(
//                         (item) => Padding(
//                           padding: const EdgeInsets.only(bottom: 8),
//                           child: Row(
//                             children: [
//                               // In the clear cart sheet - replace the Container with:
//                               CommonImageView(
//                                 url: item.product.image,
//                                 height: 30.0,
//                                 width: 30.0,
//                                 radius: 6.0,
//                                 fit: BoxFit.fill,
//                               ),
//                               const Gap(8),
//                               Expanded(
//                                 child: MyText(
//                                   text: item.product.title,
//                                   size: 12,
//                                   color: kDynamicText(Get.context!),
//                                   maxLines: 1,
//                                   textOverflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               MyText(
//                                 text: "×${item.quantity}",
//                                 size: 12,
//                                 color: kDynamicListTileSubtitle(Get.context!),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                   if (cartItems.length > 3) ...[
//                     const Gap(4),
//                     MyText(
//                       text: "...and ${cartItems.length - 3} more items",
//                       size: 12,
//                       color: kDynamicListTileSubtitle(Get.context!),
//                     ),
//                   ],

//                   const Gap(8),
//                   Divider(color: kDynamicBorder(Get.context!), height: 1),
//                   const Gap(8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       MyText(
//                         text: "Total Value:",
//                         size: 14,
//                         color: kDynamicText(Get.context!),
//                       ),
//                       MyText(
//                         text:
//                             "\$${productController.totalCartValue.toStringAsFixed(2)}",
//                         size: 16,
//                         weight: FontWeight.w700,
//                         color: kDynamicPrimary(Get.context!),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const Gap(16),
//             MyText(
//               text:
//                   "Are you sure you want to remove all items from your cart? This action cannot be undone.",
//               size: 14,
//               color: kDynamicListTileSubtitle(Get.context!),
//             ),
//             const Gap(24),
//             Row(
//               children: [
//                 // Cancel Button
//                 Expanded(
//                   child: MyButton(
//                     buttonText: "Cancel",
//                     onTap: () => Get.back(),
//                     backgroundColor: kDynamicScaffoldBackground(Get.context!),
//                     fontColor: kDynamicText(Get.context!),
//                     outlineColor: kDynamicBorder(Get.context!),
//                   ),
//                 ),
//                 const Gap(12),
//                 // Confirm Button
//                 Expanded(
//                   child: MyButton(
//                     buttonText: "Clear All",
//                     onTap: () {
//                       Get.back();
//                       productController.clearCart();
//                     },
//                     backgroundColor: Colors.red,
//                     fontColor: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//             const Gap(10),
//           ],
//         ),
//       ),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//     );
//   }

//   // Generic action bottom sheet with multiple options
//   static void showActionSheet({
//     required String title,
//     required List<SheetAction> actions,
//   }) {
//     Get.bottomSheet(
//       Container(
//         decoration: BoxDecoration(
//           color: kDynamicCard(Get.context!),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(26.0),
//             topRight: Radius.circular(26.0),
//           ),
//         ),
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Container(
//                 width: 66,
//                 height: 6,
//                 decoration: BoxDecoration(
//                   color: kDynamicListTileSubtitle(Get.context!),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//             ),
//             const Gap(20),
//             if (title.isNotEmpty) ...[
//               MyText(
//                 text: title,
//                 size: 18,
//                 weight: FontWeight.w600,
//                 color: kDynamicText(Get.context!),
//               ),
//               const Gap(16),
//             ],
//             ...actions.map(
//               (action) => Column(
//                 children: [
//                   MyButtonWithIcon(
//                     text: action.title,
//                     onTap: () {
//                       Get.back();
//                       action.onTap();
//                     },
//                     iconPath: _getIconPathForAction(action.icon),
//                     iconColor: action.isDestructive
//                         ? Colors.red
//                         : kDynamicPrimary(Get.context!),
//                     fontColor: action.isDestructive
//                         ? Colors.red
//                         : kDynamicText(Get.context!),
//                     backgroundColor: kDynamicScaffoldBackground(Get.context!),
//                     outlineColor: kDynamicBorder(Get.context!),
//                     radius: 12.0,
//                     height: 50.0,
//                     hasShadow: false,
//                     isActive: true,
//                     isLoading: false,
//                   ),
//                   if (action != actions.last) const Gap(8),
//                 ],
//               ),
//             ),
//             const Gap(12),
//             // Cancel button
//             MyButton(
//               buttonText: "Cancel",
//               onTap: () => Get.back(),
//               backgroundColor: kDynamicScaffoldBackground(Get.context!),
//               fontColor: kDynamicText(Get.context!),
//               outlineColor: kDynamicBorder(Get.context!),
//               radius: 12.0,
//               height: 50.0,
//               hasicon: false,
//               hasshadow: false,
//               isactive: true,
//               isLoading: false,
//             ),
//             const Gap(10),
//           ],
//         ),
//       ),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//     );
//   }

//   // Helper method to convert IconData to icon path
//   static String _getIconPathForAction(IconData? icon) {
//     if (icon == null) return Assets.cartfilled; // Use a placeholder asset

//     // Map common IconData to your asset paths
//     switch (icon) {
//       case Icons.remove_red_eye_outlined:
//         return Assets.cartfilled; // Replace with your actual asset path
//       case Icons.shopping_cart_outlined:
//         return Assets.cartfilled; // Replace with your actual asset path
//       case Icons.share_outlined:
//         return Assets.cartfilled; // Replace with your actual asset path
//       case Icons.filter_alt:
//         return Assets.filter; // Replace with your actual asset path
//       case Icons.clear_all:
//         return Assets.cartfilled; // Replace with your actual asset path
//       case Icons.check:
//         return Assets.check; // Replace with your actual asset path
//       default:
//         return Assets.cartfilled; // Default placeholder
//     }
//   }

//   // Product options bottom sheet
//   static void showProductOptionsSheet({
//     required ProductModel product,
//     required VoidCallback onViewDetails,
//     required VoidCallback onAddToCart,
//   }) {
//     showActionSheet(
//       title: "Product Options",
//       actions: [
//         SheetAction(
//           title: "View Details",
//           icon: Icons.remove_red_eye_outlined,
//           onTap: onViewDetails,
//         ),
//         SheetAction(
//           title: "Add to Cart",
//           icon: Icons.shopping_cart_outlined,
//           onTap: onAddToCart,
//         ),
//         SheetAction(
//           title: "Share Product",
//           icon: Icons.share_outlined,
//           onTap: () {
//             // Implement share functionality
//           },
//         ),
//       ],
//     );
//   }

//   // Sort options bottom sheet
//   static void showSortOptionsSheet({
//     required String currentSort,
//     required Function(String) onSortSelected,
//   }) {
//     final sortOptions = [
//       {"label": "Price: Low to High", "value": "price_low"},
//       {"label": "Price: High to Low", "value": "price_high"},
//       {"label": "Most Popular", "value": "popular"},
//       {"label": "Newest First", "value": "newest"},
//       {"label": "Highest Rated", "value": "rating"},
//     ];

//     showActionSheet(
//       title: "Sort By",
//       actions: sortOptions
//           .map(
//             (option) => SheetAction(
//               title: option["label"]!,
//               icon: currentSort == option["value"] ? Icons.check : null,
//               onTap: () => onSortSelected(option["value"]!),
//             ),
//           )
//           .toList(),
//     );
//   }

//   // Filter options bottom sheet
//   static void showFilterSheet({
//     required VoidCallback onApplyFilters,
//     required VoidCallback onClearFilters,
//   }) {
//     showActionSheet(
//       title: "Filters",
//       actions: [
//         SheetAction(
//           title: "Apply Filters",
//           icon: Icons.filter_alt,
//           onTap: onApplyFilters,
//         ),
//         SheetAction(
//           title: "Clear All Filters",
//           icon: Icons.clear_all,
//           onTap: onClearFilters,
//           isDestructive: true,
//         ),
//       ],
//     );
//   }

//   // Quantity selector bottom sheet
//   static void showQuantitySheet({
//     required ProductModel product,
//     required ProductController productController,
//     required VoidCallback onAddToCart,
//   }) {
//     Get.bottomSheet(
//       Container(
//         decoration: BoxDecoration(
//           color: kDynamicCard(Get.context!),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(26.0),
//             topRight: Radius.circular(26.0),
//           ),
//         ),
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Container(
//                 width: 66,
//                 height: 6,
//                 decoration: BoxDecoration(
//                   color: kDynamicListTileSubtitle(Get.context!),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//             ),
//             const Gap(20),
//             MyText(
//               text: "Select Quantity",
//               size: 18,
//               weight: FontWeight.w600,
//               color: kDynamicText(Get.context!),
//             ),
//             const Gap(16),
//             // Quantity Controls
//             Container(
//               decoration: BoxDecoration(
//                 color: kDynamicCard(Get.context!),
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: kDynamicBorder(Get.context!)),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Decrease button
//                   IconButton(
//                     onPressed: productController.decreaseQuantity,
//                     icon: SvgPicture.asset(
//                       Assets.minus,
//                       color: kDynamicIcon(Get.context!),
//                       height: 26,
//                     ),
//                   ),
//                   // Quantity
//                   Obx(
//                     () => Container(
//                       width: 60,
//                       alignment: Alignment.center,
//                       child: MyText(
//                         text: productController.quantity.value.toString(),
//                         size: 18,
//                         weight: FontWeight.bold,
//                         color: kDynamicText(Get.context!),
//                       ),
//                     ),
//                   ),
//                   // Increase button
//                   IconButton(
//                     onPressed: productController.increaseQuantity,
//                     icon: SvgPicture.asset(
//                       Assets.add,
//                       color: kDynamicIcon(Get.context!),
//                       height: 26,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Gap(24),
//             Row(
//               children: [
//                 // Cancel Button
//                 Expanded(
//                   child: MyButton(
//                     buttonText: "Cancel",
//                     onTap: () => Get.back(),
//                   ),
//                 ),
//                 const Gap(12),
//                 // Add to Cart Button
//                 Expanded(
//                   child: MyButton(
//                     buttonText: "Add to Cart",
//                     onTap: () {
//                       Get.back();
//                       onAddToCart();
//                     },
//                     backgroundColor: kDynamicPrimary(Get.context!),
//                   ),
//                 ),
//               ],
//             ),
//             const Gap(10),
//           ],
//         ),
//       ),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//     );
//   }

//   // Color selection bottom sheet
//   static void showColorSelectionSheet({
//     required ProductModel product,
//     required ProductController productController,
//     required List<Color> colors,
//     required VoidCallback onAddToCart,
//   }) {
//     Get.bottomSheet(
//       Container(
//         decoration: BoxDecoration(
//           color: kDynamicCard(Get.context!),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(26.0),
//             topRight: Radius.circular(26.0),
//           ),
//         ),
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Container(
//                 width: 66,
//                 height: 6,
//                 decoration: BoxDecoration(
//                   color: kDynamicListTileSubtitle(Get.context!),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//             ),
//             const Gap(20),
//             MyText(
//               text: "Select Color",
//               size: 18,
//               weight: FontWeight.w600,
//               color: kDynamicText(Get.context!),
//             ),
//             const Gap(16),
//             Wrap(
//               spacing: 12,
//               runSpacing: 12,
//               children: List.generate(colors.length, (index) {
//                 return GestureDetector(
//                   onTap: () => productController.setSelectedColor(index),
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: colors[index],
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(
//                         color:
//                             productController.selectedColorIndex.value == index
//                             ? kDynamicBorder(Get.context!)
//                             : Colors.transparent,
//                         width: 2.5,
//                       ),
//                     ),
//                     child: productController.selectedColorIndex.value == index
//                         ? SvgPicture.asset(
//                             Assets.check,
//                             height: 22,
//                             color: kDynamicIcon(Get.context!),
//                           )
//                         : const SizedBox(width: 16, height: 16),
//                   ),
//                 );
//               }),
//             ),
//             const Gap(24),
//             Row(
//               children: [
//                 // Cancel Button
//                 Expanded(
//                   child: MyButton(
//                     buttonText: "Cancel",
//                     onTap: () => Get.back(),
//                   ),
//                 ),
//                 const Gap(12),
//                 // Add to Cart Button
//                 Expanded(
//                   child: MyButton(
//                     buttonText: "Add to Cart",
//                     onTap: () {
//                       Get.back();
//                       onAddToCart();
//                     },
//                     backgroundColor: kDynamicPrimary(Get.context!),
//                   ),
//                 ),
//               ],
//             ),
//             const Gap(10),
//           ],
//         ),
//       ),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//     );
//   }
// }

// // Add to BottomSheetHelper class
// void showAddressPreviewSheet({
//   required String addressTitle,
//   required String fullAddress,
//   required Function(String title, String address) onEdit,
//   VoidCallback? onDelete,
// }) {
//   Get.bottomSheet(
//     Container(
//       decoration: BoxDecoration(
//         color: kDynamicCard(Get.context!),
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: kDynamicListTileSubtitle(Get.context!),
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//           ),
//           const Gap(20),
//           MyText(
//             text: "Shipping Address",
//             size: 18,
//             weight: FontWeight.w600,
//             color: kDynamicText(Get.context!),
//           ),
//           const Gap(16),
//           // Current Address Display
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: kDynamicScaffoldBackground(Get.context!),
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: kDynamicBorder(Get.context!)),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     SvgPicture.asset(
//                       Assets.pencilfilled, // Your location icon
//                       height: 20,
//                       color: kDynamicPrimary(Get.context!),
//                     ),
//                     const Gap(12),
//                     MyText(
//                       text: addressTitle,
//                       size: 16,
//                       weight: FontWeight.w600,
//                       color: kDynamicText(Get.context!),
//                     ),
//                   ],
//                 ),
//                 const Gap(12),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 32),
//                   child: MyText(
//                     text: fullAddress,
//                     size: 14,
//                     color: kDynamicListTileSubtitle(Get.context!),
//                     maxLines: 4,
//                     textOverflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Gap(24),
//           Row(
//             children: [
//               // Delete Button (only for existing addresses)
//               if (onDelete != null) ...[
//                 Expanded(
//                   child: MyButton(
//                     buttonText: "Delete",
//                     onTap: () {
//                       Get.back();
//                       onDelete();
//                     },
//                     backgroundColor: Colors.red,
//                     fontColor: Colors.white,
//                   ),
//                 ),
//                 const Gap(12),
//               ],
//               // Cancel Button
//               Expanded(
//                 child: MyButton(
//                   buttonText: "Cancel",
//                   onTap: () => Get.back(),
//                   backgroundColor: kDynamicScaffoldBackground(Get.context!),
//                   fontColor: kDynamicText(Get.context!),
//                   outlineColor: kDynamicBorder(Get.context!),
//                 ),
//               ),
//               const Gap(12),
//               // Edit Button
//               Expanded(
//                 child: MyButton(
//                   buttonText: "Edit Address",
//                   onTap: () {
//                     Get.back(); // Close the sheet first
//                     Get.to(
//                       () => EditShippingAddressScreen(
//                         currentTitle: addressTitle,
//                         currentAddress: fullAddress,
//                         onSave: onEdit,
//                         onDelete: onDelete,
//                       ),
//                       transition: Transition.cupertino,
//                     );
//                   },
//                   backgroundColor: kDynamicPrimary(Get.context!),
//                 ),
//               ),
//             ],
//           ),
//           const Gap(10),
//         ],
//       ),
//     ),
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//   );
// }

// // Add to BottomSheetHelper class
// void showEditAddressSheet({
//   String? currentTitle,
//   String? currentAddress,
//   required Function(String title, String address) onSave,
//   VoidCallback? onDelete,
// }) {
//   final TextEditingController titleController = TextEditingController(
//     text: currentTitle,
//   );
//   final TextEditingController addressController = TextEditingController(
//     text: currentAddress,
//   );

//   Get.bottomSheet(
//     Container(
//       decoration: BoxDecoration(
//         color: kDynamicCard(Get.context!),
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: kDynamicListTileSubtitle(Get.context!),
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//           ),
//           const Gap(20),
//           MyText(
//             text: currentTitle == null ? "Add New Address" : "Edit Address",
//             size: 18,
//             weight: FontWeight.w600,
//             color: kDynamicText(Get.context!),
//           ),
//           const Gap(16),
//           // Address Title Field
//           MyTextField(
//             controller: titleController,
//             hint: "Address Title (e.g., Home, Office)",
//             label: "Title",
//           ),
//           const Gap(12),
//           // Address Field
//           MyTextField(
//             controller: addressController,
//             hint: "Full Address",
//             label: "Address",
//             maxLines: 3,
//           ),
//           const Gap(24),
//           Row(
//             children: [
//               // Delete Button (only for existing addresses)
//               if (currentTitle != null && onDelete != null) ...[
//                 Expanded(
//                   child: MyButton(
//                     buttonText: "Delete",
//                     onTap: () {
//                       Get.back();
//                       onDelete();
//                     },
//                     backgroundColor: Colors.red,
//                   ),
//                 ),
//                 const Gap(12),
//               ],
//               // Cancel Button
//               Expanded(
//                 child: MyButton(buttonText: "Cancel", onTap: () => Get.back()),
//               ),
//               const Gap(12),
//               // Save Button
//               Expanded(
//                 child: MyButton(
//                   buttonText: "Save",
//                   onTap: () {
//                     if (titleController.text.trim().isEmpty ||
//                         addressController.text.trim().isEmpty) {
//                       AppToast.error("Please fill all fields");
//                       return;
//                     }
//                     Get.back();
//                     onSave(
//                       titleController.text.trim(),
//                       addressController.text.trim(),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//           const Gap(10),
//         ],
//       ),
//     ),
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//   );
// }

// // Model for sheet actions
// class SheetAction {
//   final String title;
//   final IconData? icon;
//   final VoidCallback onTap;
//   final bool isDestructive;

//   SheetAction({
//     required this.title,
//     this.icon,
//     required this.onTap,
//     this.isDestructive = false,
//   });
// }
