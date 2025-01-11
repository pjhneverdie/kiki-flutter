library home_screen;

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:go_router/go_router.dart';

import 'package:kiki/app/config/data/iconfig.dart';
import 'package:kiki/app/config/theme/app_assets.dart';
import 'package:kiki/app/config/theme/app_colors.dart';
import 'package:kiki/app/di/get_it_instance.dart';
import 'package:kiki/app/walk_through/setting/view/my_view/screen/my_screen.dart';
import 'package:kiki/app/walk_through/setting/view/setting_view/screen/setting_screen.dart';
import 'package:kiki/common/model/simple_data_state.dart';
import 'package:kiki/common/util/screen_util_util.dart';
import 'package:kiki/common/util/use_color_mode.dart';
import 'package:kiki/feature/feed/cubit/feed_read_cubit.dart';
import 'package:kiki/feature/feed/model/feed_template_model.dart';
import 'package:kiki/feature/feed/view/component/feed_card.dart';
import 'package:kiki/feature/feed/view/save_feed_view/screen/save_feed_screen.dart';

part 'package:kiki/app/walk_through/home/view/home_view/component/fab.dart';

part 'package:kiki/app/walk_through/home/view/home_view/component/options.dart';

part 'package:kiki/app/walk_through/home/view/home_view/component/admob_banner.dart';

class HomeScreen extends StatefulWidget {
  static const String PATH = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FeedTemplateModel? _feedTemplateModel;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: useColorMode(
        context,
        context.colors.middleWhite,
        context.colors.strongBlack,
      ),
      floatingActionButton: _FAB(
        onPressed: () async =>
            await _feedTemplateModel?.share(getIt<IConfig>().baseUrl),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 7.5.autoSizeH,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0.autoSizeW,
              ),
              child: _Options(
                onSettingTap: () {
                  context.push(SettingScreen.FULL_PATH);
                },
                onMyTap: () {
                  context.push(MyScreen.FULL_PATH);
                },
                onTemplateTap: () async {
                  final bool? isChanged =
                      await context.push(SaveFeedScreen.FULL_PATH).then((data) {
                    return true;
                  }).whenComplete(() async {
                    await getIt<FeedReadCubit>().getAllFeeds();
                  });
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<FeedReadCubit,
                  SimpleDataState<List<FeedTemplateModel>>>(
                bloc: getIt<FeedReadCubit>()..getAllFeeds(),
                builder: (context, state) {
                  if (state is! Data) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final int padding = state.data!.isEmpty ? 2 : 1;

                  return Swiper(
                    autoplay: false,
                    itemWidth: 250.0.autoSizeSP,
                    itemHeight: 250.0.autoSizeSP,
                    layout: SwiperLayout.STACK,
                    itemCount: state.data!.length + padding,
                    onIndexChanged: (int index) {
                      if (index < padding) {
                        _feedTemplateModel = null;
                        return;
                      }

                      _feedTemplateModel = state.data![index - padding];
                    },
                    itemBuilder: (BuildContext context, int index) {
                      if (index < padding) {
                        return FeedCard(
                          image: Image.asset(
                            useColorMode(
                              context,
                              AppAssets.splash_logo_light,
                              AppAssets.splash_logo_dark,
                            ),
                          ),
                        );
                      }

                      return GestureDetector(
                        onTap: () async {
                          final bool? isChanged = await context
                              .push(
                            "${SaveFeedScreen.FULL_PATH}?feedTemplateModel=${jsonEncode(state.data![index - padding].toJson())}",
                          )
                              .then((data) {
                            return true;
                          }).whenComplete(() async {
                            await getIt<FeedReadCubit>().getAllFeeds();
                          });
                        },
                        child: FeedCard(
                          image: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: state.data![index - padding].imageUrl,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Center(
                                child: Text(
                                  "템플릿 저장 기한이 만료됐습니다.",
                                  style: TextStyle(
                                    color: useColorMode(
                                      context,
                                      context.colors.strongBlack,
                                      context.colors.weakGray,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
