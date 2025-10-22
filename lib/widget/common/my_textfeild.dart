import 'package:nutri/constants/export.dart';

class MyTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool? isObSecure;
  final bool? haveLabel;
  final bool? isReadOnly;
  final double? marginBottom;
  final double? radius;
  final int? maxLines;
  final double? labelSize;
  final double? hintsize;
  final FocusNode? focusNode;
  final Color? filledColor;
  final Color? focusedFillColor;
  final bool? autoFocus;
  final Color? bordercolor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? focusBorderColor;
  final Widget? prefix;
  final Widget? suffix;
  final FontWeight? labelWeight;
  final FontWeight? hintWeight;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final double? height;
  final double? width;
  final String? Function(String?)? validator;
  final bool? showPasswordToggle;
  final bool? isPin;
  final List<TextInputFormatter>? inputFormatters;
  final String? obscuringCharacter;
  final TextStyle? style;
  final TextAlign? textAlign; // Changed from bool? to TextAlign?

  const MyTextField({
    super.key,
    this.controller,
    this.hint,
    this.label,
    this.onChanged,
    this.isObSecure = false,
    this.marginBottom = 18.0,
    this.maxLines = 1,
    this.filledColor,
    this.focusedFillColor,
    this.hintColor,
    this.labelColor,
    this.haveLabel = true,
    this.labelSize,
    this.hintsize,
    this.prefix,
    this.suffix,
    this.autoFocus = false,
    this.labelWeight,
    this.hintWeight,
    this.keyboardType,
    this.isReadOnly = false,
    this.onTap,
    this.bordercolor,
    this.focusBorderColor,
    this.focusNode,
    this.radius = 16.0,
    this.height = 58,
    this.width,
    this.validator,
    this.showPasswordToggle = false,
    this.isPin = false,
    this.inputFormatters,
    this.obscuringCharacter = '•',
    this.style,
    this.textAlign, // Updated type
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isFocused = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = widget.focusNode?.hasFocus ?? false;
    });
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_onFocusChange);
    super.dispose();
  }

  Widget _buildPasswordToggle() {
    return IconButton(
      icon: Icon(
        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: kDynamicHintText(context),
        size: 20,
      ),
      onPressed: () {
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = kIsDarkMode(context);

    // Default colors based on theme
    final defaultFilledColor = isDarkMode ? kCardDark : kGreyColor2;
    final defaultFocusedFillColor = isDarkMode ? kTileDark : kGreyContainerGreyColor2;
    final defaultBorderColor = isDarkMode ? kTileDark : kGreyContainerGreyColor2;
    final defaultFocusBorderColor = kDynamicText(context);
    final defaultHintColor = kDynamicHintText(context);
    final defaultLabelColor = kDynamicInputLabel(context);
    final defaultTextColor = kDynamicInputText(context);

    return Padding(
      padding: EdgeInsets.only(bottom: widget.marginBottom ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null && _isFocused)
            MyText(
              text: widget.label ?? '',
              size: widget.labelSize ?? 10,
              paddingBottom: 8,
              color: widget.labelColor ?? defaultLabelColor,
              fontFamily: AppFonts.Figtree,
              weight: widget.labelWeight ?? FontWeight.w500,
            ),
          Container(
            width: widget.width ?? double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius ?? 30.0),
              color: widget.focusedFillColor ?? defaultFocusedFillColor,
            ),
            child: TextFormField(
              focusNode: widget.focusNode,
              onTap: widget.onTap,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: widget.isPin == true
                  ? TextInputType.number
                  : widget.keyboardType,
              inputFormatters: widget.isPin == true
                  ? [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly,
                    ]
                  : widget.inputFormatters,
              obscureText: (widget.isObSecure ?? false) && !_isPasswordVisible,
              obscuringCharacter: widget.obscuringCharacter ?? '•',
              textAlign: widget.textAlign ?? TextAlign.start,
              style: widget.style ?? TextStyle(
                fontSize: widget.isPin == true ? 18 : 14, // Larger font for PIN
                fontWeight: widget.isPin == true ? FontWeight.bold : FontWeight.w400,
                fontFamily: AppFonts.Figtree,
                decoration: TextDecoration.none,
                color: defaultTextColor,
              ),
              maxLines: widget.maxLines ?? 1,
              readOnly: widget.isReadOnly ?? false,
              controller: widget.controller,
              autofocus: widget.autoFocus ?? false,
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: widget.onChanged,
              validator: widget.validator,
              decoration: InputDecoration(
                filled: true,
                fillColor: _isFocused
                    ? widget.focusedFillColor ?? defaultFocusedFillColor
                    : widget.filledColor ?? defaultFilledColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 20.0),
                  borderSide: BorderSide(
                    color: widget.focusBorderColor ?? defaultFocusBorderColor,
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 20.0),
                  borderSide: BorderSide(
                    color: _isFocused
                        ? widget.focusBorderColor ?? defaultFocusBorderColor
                        : widget.bordercolor ?? defaultBorderColor,
                    width: 1,
                  ),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: widget.prefix,
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: widget.showPasswordToggle == true
                      ? _buildPasswordToggle()
                      : widget.suffix,
                ),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontSize: widget.hintsize ?? 14,
                  fontFamily: AppFonts.Figtree,
                  color: widget.hintColor ?? defaultHintColor,
                  fontWeight: widget.hintWeight ?? FontWeight.w400,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 20.0),
                  borderSide: BorderSide(
                    width: 1,
                    color: kDynamicError(context),
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 20.0),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: kDynamicError(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}