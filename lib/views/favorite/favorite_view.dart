import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/constants/colors/color_constants.dart';
import 'package:medito/constants/styles/widget_styles.dart';
import 'package:medito/utils/fade_page_route.dart';
import 'package:medito/views/favorite/widgets/favorite_list/favorite_list.dart';
import 'package:medito/views/settings/settings_screen.dart';
import 'package:medito/widgets/markdown_widget.dart';
import 'package:medito/widgets/network_image_widget.dart';

class FavoriteView extends ConsumerStatefulWidget {
  const FavoriteView({super.key});

  @override
  ConsumerState<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends ConsumerState<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 36,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFFF9900),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
              ),
              child: SafeArea(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Enjoy all your',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'favorites',
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        FadePageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      ),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Text(
                            'DN',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const FavoriteList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPortraitLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .4,
          color: ColorConstants.softGrey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Your favorites',
                    style: Theme.of(context).primaryTextTheme.titleLarge?.copyWith(
                      fontFamily: SourceSerif,
                      color: ColorConstants.white,
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Favorite tracks and they will appear here',
                    style: Theme.of(context).primaryTextTheme.titleLarge?.copyWith(
                      fontFamily: DmSans,
                      color: ColorConstants.white,
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildTrackContent(isLandscape: false),
      ],
    );
  }

  Widget _buildTrackContent({required bool isLandscape}) {
    return  _buildContentWithData(context, ref, isLandscape: isLandscape);
  }

  Widget _buildContentWithData(
      BuildContext context,
      WidgetRef ref,
      { required bool isLandscape }) {
    return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[],
    );
  }

  Widget _buildLandscapeLayout() {
    var size = MediaQuery.of(context).size;
    var maxWidth = size.width * 0.25;
    var maxHeight = size.height * 0.45;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
                maxHeight: maxHeight,
              ),
              child: AspectRatio(
                aspectRatio: 1,
                child: _buildCoverImage(),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: maxHeight,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title(context, 'title'),
                      const SizedBox(height: 8),
                      _getSubTitle(
                        context,
                        '',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildTrackContent(isLandscape: true),
      ],
    );
  }

  Text _title(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).primaryTextTheme.titleLarge?.copyWith(
        fontFamily: SourceSerif,
        color: ColorConstants.white,
        letterSpacing: 0.2,
        fontSize: 24,
      ),
    );
  }

  Widget _getSubTitle(BuildContext context, String? subTitle) {
    if (subTitle != null) {
      var bodyLarge = Theme.of(context).primaryTextTheme.bodyLarge;

      return MarkdownWidget(
        body: subTitle,
        selectable: true,
        textAlign: WrapAlignment.start,
        p: bodyLarge?.copyWith(
          color: ColorConstants.white,
          fontFamily: DmSans,
          fontSize: 16,
        ),
        a: bodyLarge?.copyWith(
          color: ColorConstants.white,
          fontFamily: DmSans,
          decoration: TextDecoration.underline,
          fontSize: 16,
        ),
        onTapLink: (text, href, title) {},
      );
    }

    return const SizedBox();
  }

  Widget _buildCoverImage() {
    return _buildImageWithData('');
  }

  Widget _buildImageWithData(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: NetworkImageWidget(
        url: url,
        shouldCache: true,
      ),
    );
  }
}
