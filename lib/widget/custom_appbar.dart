import 'package:nutri/constants/export.dart';
import 'package:nutri/generated/assets.dart';
import 'package:nutri/widget/common_image_view_widget.dart';
import 'package:nutri/widget/my_text_widget.dart';
import 'package:nutri/widget/my_textfeild.dart';


class GenericAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool showSearch;
  final Function(String)? onSearchChanged;
  final String? searchHint;
  final double logoSize;
  final VoidCallback? onSettingsTap; // Add this

  const GenericAppBar({
    super.key,
    required this.title,
    this.showSearch = false,
    this.onSearchChanged,
    this.searchHint,
    this.logoSize = 22.0,
    this.onSettingsTap, // Add this
  });

  @override
  State<GenericAppBar> createState() => _GenericAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _GenericAppBarState extends State<GenericAppBar> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_searchFocusNode.hasFocus && _searchController.text.isEmpty) {
      _toggleSearch();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    widget.onSearchChanged?.call(query);
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        widget.onSearchChanged?.call('');
        _searchFocusNode.unfocus();
      } else {
        // Focus on search field when it appears
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _searchFocusNode.requestFocus();
        });
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _onSearchChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;

        return AppBar(
          backgroundColor: kDynamicScaffoldBackground(context),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: _isSearching
              ? _buildSearchField()
              : Row(
                  children: [
                    // Logo
                    Image.asset(
                      isDarkMode ? Assets.funicalight : Assets.funicadark,
                      height: widget.logoSize,
                      width: widget.logoSize * 0.8,
                    ),
                    const Gap(12),

                    // Title
                    Expanded(
                      child: MyText(
                        text: widget.title,
                        size: 18,
                        weight: FontWeight.w600,
                        color: kDynamicText(context),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Action Icons
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Search Icon
                        if (widget.showSearch && !_isSearching)
                          IconButton(
                            icon: SvgPicture.asset(
                              Assets.searchunfilled,
                              height: 22,
                              color: kDynamicIcon(context),
                            ),
                            onPressed: _toggleSearch,
                          ),

                        // Settings Icon
                        if (widget.onSettingsTap != null)
                          IconButton(
                            icon: SvgPicture.asset(
                              Assets.settings,
                              height: 22,
                              color: kDynamicIcon(context),
                            ),
                            onPressed: widget.onSettingsTap,
                          ),
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildSearchField() {
    return Row(
      children: [
        Expanded(
          child: Container(
            key: const ValueKey('searchField'),
            width: double.infinity,
            margin: const EdgeInsets.only(right: 10, top: 26.0),
            child: MyTextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              hint: widget.searchHint ?? 'Search...',
              prefix: SvgPicture.asset(
                Assets.searchunfilled,
                height: 20,
                color: kDynamicIcon(context),
              ),
              suffix: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: kDynamicIcon(context),
                        size: 18,
                      ),
                      onPressed: _clearSearch,
                    )
                  : null,
              onChanged: _onSearchChanged,
              hintColor: kDynamicListTileSubtitle(context),
            ),
          ),
        ),
        const Gap(8),
        // Close button
        IconButton(
          icon: Icon(Icons.close, color: kDynamicText(context)),
          onPressed: _toggleSearch,
        ),
      ],
    );
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool centerTitle;
  final bool showLeading;
  final double textSize;
  final TextAlign? textAlign;

  final bool showNotificationIcon;
  final bool showAvatarIcon;
  final bool showBasketIcon;
  final bool showMessageIcon;
  final bool enableSearch;
  final Function(String)? onSearchChanged; // Add this line

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.onBackTap,
    this.centerTitle = true,
    this.showLeading = false,
    this.textSize = 18,
    this.textAlign,
    this.showNotificationIcon = false,
    this.showAvatarIcon = false,
    this.showBasketIcon = false,
    this.showMessageIcon = false,
    this.enableSearch = false,
    this.onSearchChanged, // Add this line
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController =
      TextEditingController(); // Add this

  String get currentLangCode => Get.locale?.languageCode ?? 'en';
  bool get isRTL => currentLangCode == 'ar' || currentLangCode == 'sa';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged); // Add this
  }

  @override
  void dispose() {
    _searchController.dispose(); // Add this
    super.dispose();
  }

  void _onSearchChanged() {
    // Call the callback when search text changes
    widget.onSearchChanged?.call(_searchController.text);
  }

  void _clearSearch() {
    _searchController.clear();
    widget.onSearchChanged?.call('');
  }

  Widget _buildBackButton(BuildContext context) {
    final backIcon = Padding(
      padding: const EdgeInsets.all(10),
      child: CommonImageView(
        imagePath: Assets.imagesArrowBack,
        height: 16,
        color: kDynamicIcon(context),
      ),
    );

    return InkWell(
      onTap: () {
        if (_isSearching) {
          setState(() {
            _isSearching = false;
            _clearSearch(); // Clear search when exiting
          });
        } else {
          if (widget.onBackTap != null) {
            widget.onBackTap!();
          } else {
            Get.back();
          }
        }
      },
      child: backIcon,
    );
  }

  List<Widget> _buildOptionalIcons(BuildContext context) {
    final List<Map<String, dynamic>> iconConfigs = [
      {
        'show': widget.showMessageIcon,
        'asset': Assets.up,
        'padding': const EdgeInsets.symmetric(horizontal: 4),
      },
      {
        'show': widget.showBasketIcon,
        'asset': Assets.imagesBasketIcon,
        'padding': const EdgeInsets.symmetric(horizontal: 4),
      },
      {
        'show': widget.showNotificationIcon,
        'asset': Assets.up,
        'padding': const EdgeInsets.symmetric(horizontal: 4),
      },
      {
        'show': widget.showAvatarIcon,
        'asset': Assets.imagesAppbarAvatar,
        'padding': const EdgeInsets.symmetric(horizontal: 8),
      },
    ];

    final orderedConfigs = isRTL ? iconConfigs.reversed.toList() : iconConfigs;

    return orderedConfigs.where((config) => config['show'] as bool).map((
      config,
    ) {
      return Padding(
        padding: config['padding'] as EdgeInsets,
        child: Bounce(
          onTap: () {},
          child: CommonImageView(
            imagePath: config['asset'] as String,
            height: 36,
            color: config['asset'] != Assets.imagesAppbarAvatar
                ? kDynamicIcon(context)
                : null,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final optionalIcons = _buildOptionalIcons(context);
    final hasOptionalIcons = optionalIcons.isNotEmpty;

    return AppBar(
      backgroundColor: kDynamicScaffoldBackground(context),
      automaticallyImplyLeading: false,
      centerTitle: false,
      leading: _isSearching
          ? _buildBackButton(context)
          : (widget.showLeading ? _buildBackButton(context) : null),
      titleSpacing: 0,
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _isSearching
            ? Container(
                key: const ValueKey('searchField'),
                width: double.infinity,
                margin: const EdgeInsets.only(right: 10, top: 26.0),
                child: MyTextField(
                  controller: _searchController, // Add controller
                  keyboardType: TextInputType.text,
                  hint: 'Search ${widget.title}...', // More specific hint
                  prefix: SvgPicture.asset(
                    Assets.searchunfilled,
                    height: 20,
                    color: kDynamicIcon(context),
                  ),
                  suffix: _searchController.text.isNotEmpty
                      ? Bounce(
                          onTap: _clearSearch,
                          child: SvgPicture.asset(
                            Assets.filter,
                            height: 20,
                            color: kDynamicIcon(context),
                          ),
                        )
                      : SvgPicture.asset(
                          Assets.filter,
                          height: 20,
                          color: kDynamicIcon(context),
                        ),
                  autoFocus: true,
                  onChanged: (value) {
                    // Handled by controller listener
                  },
                ),
              )
            : MyText(
                key: const ValueKey('titleText'),
                text: widget.title ?? "",
                size: widget.textSize,
                color: kDynamicText(context),
                weight: FontWeight.w700,
                textAlign:
                    widget.textAlign ??
                    (isRTL ? TextAlign.right : TextAlign.left),
              ),
      ),
      actions: !_isSearching
          ? [
              if (widget.enableSearch)
                IconButton(
                  icon: SvgPicture.asset(
                    Assets.searchunfilled,
                    height: 20,
                    color: kDynamicIcon(context),
                  ),
                  onPressed: () => setState(() => _isSearching = true),
                ),
              if (!isRTL && hasOptionalIcons) ...optionalIcons,
              if (widget.actions != null) ...widget.actions!,
              if (isRTL && hasOptionalIcons) ...optionalIcons,
            ]
          : [], // no actions while searching
    );
  }
}
