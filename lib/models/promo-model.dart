
// Promo Code Model
class PromoCode {
  final String code;
  final String description;
  final DiscountType discountType;
  final int discountValue;
  final double minOrderAmount;

  const PromoCode({
    required this.code,
    required this.description,
    required this.discountType,
    required this.discountValue,
    required this.minOrderAmount,
  });

  const PromoCode.empty()
      : code = "",
        description = "",
        discountType = DiscountType.percentage,
        discountValue = 0,
        minOrderAmount = 0;
}

enum DiscountType {
  percentage,
  fixed,
  freeShipping,
}