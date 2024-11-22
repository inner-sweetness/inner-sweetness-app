import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medito/utils/fade_page_route.dart';
import 'package:medito/views/home/widgets/home_logo.dart';
import 'package:medito/views/home/widgets/home_media/home_media.dart';
import 'package:medito/views/settings/settings_screen.dart';
import 'package:medito/widgets/snippet_separator.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const HomeLogo(),
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
                      const SizedBox(height: 16),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Aaron, enjoy your',
                              style: TextStyle(
                                fontSize: 32,
                                color: Color(0xFFFFF500),
                              ),
                            ),
                            TextSpan(
                              text: '\nweekly sweets',
                              style: TextStyle(
                                fontSize: 32,
                                color: Color(0xFFFFF500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SizedBox(
                          height: 390,
                          width: 330,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 380,
                                  width: 320,
                                  color: const Color(0xFF20AF6A),
                                ),
                              ),
                              Image.asset(
                                'assets/images/home_image_1.jpeg',
                                height: 380,
                                width: 320,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: SizedBox(
                          height: 390,
                          width: 330,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 380,
                                  width: 320,
                                  color: const Color(0xFF20AF6A),
                                ),
                              ),
                              Image.asset(
                                'assets/images/home_image_2.jpeg',
                                height: 380,
                                width: 320,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Dive in',
                        style: TextStyle(
                          color: Color(0xFF03F480),
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SvgPicture.asset('assets/images/dive_in_line.svg'),
                      CarouselSlider(
                        items: <Widget>[
                          Image.asset(
                            'assets/images/card_1.png',
                            fit: BoxFit.contain,
                          ),
                          Image.asset(
                            'assets/images/card_2.png',
                            fit: BoxFit.contain,
                          ),
                          Image.asset(
                            'assets/images/card_3.png',
                            fit: BoxFit.contain,
                          ),
                        ],
                        options: CarouselOptions(
                          height: 480,
                          viewportFraction: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const SnippetSeparator.right(color: Colors.white),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Image.asset(
                    'assets/images/home_image_3.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                const SnippetSeparator.left(color: Colors.white),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(56),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'DOWNLOAD',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.file_copy,
                                color: Colors.white,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(56),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'SHARE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 560,
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xFF0150FF),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/player_home_background.svg',
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Music handpicked for you this week',
                              style: TextStyle(
                                color: Color(0xFFFEE440),
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Material(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 160,
                                          width: 247,
                                          child: Stack(
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/home_image_4.png',
                                                fit: BoxFit.fill,
                                                height: 160,
                                                width: 247,
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: SvgPicture.asset(
                                                    'assets/images/spotify_colored_icon.svg',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        const SizedBox(
                                          width: 235,
                                          child: Text(
                                            'STAY CALM',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const SizedBox(
                                          width: 235,
                                          child: Text(
                                            'Cory Ellison',
                                            style: TextStyle(
                                              color: Color(0xFF404040),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        SizedBox(
                                          height: 3,
                                          width: 235,
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  height: .5,
                                                  width: 235,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  height: 3,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius: BorderRadius.circular(24)
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.pause,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const HomeMedia(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {} // 0xFF0150FF

  @override
  bool get wantKeepAlive => true;
}
