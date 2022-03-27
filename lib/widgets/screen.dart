import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';
import '../bloc/favorites/favorites_state.dart';
import '../bloc/navigation/bottom_navigation_state.dart';
import '../cubit/header_cubit.dart';
import 'bottom_navigation.dart';
import 'default_text.dart';

class Screen extends Scaffold {
  Screen({
    Key key,
    AppBar appBar,
    Color backgroundColor,
    ScreenHeader header,
    this.withBottomNavigation = false,
    this.withDismissKeyboard = false,
    this.onNavigationRouteChange,
    @required Widget body,
    Color contentBackgroundColor,
    bool safeAreaTop,
    bool safeAreaBottom,
    bool safeAreaLeft,
    bool safeAreaRight,
  }) : super(
          key: key,
          backgroundColor: backgroundColor ?? Colors.white,
          appBar: appBar,
          body: _Page(
            _Body(
              body: body,
              header: header,
              contentBackgroundColor: contentBackgroundColor,
              safeAreaTop: safeAreaTop,
              safeAreaLeft: safeAreaLeft,
              safeAreaRight: safeAreaRight,
              safeAreaBottom: safeAreaBottom,
            ),
            withDismissKeyboard: withDismissKeyboard,
          ),
          bottomNavigationBar:
              withBottomNavigation ? const BottomNavigation() : null,
        );

  final bool withBottomNavigation;
  final bool withDismissKeyboard;
  final Function(Routes) onNavigationRouteChange;
}

class _Page extends StatelessWidget {
  const _Page(
    this.body, {
    this.withDismissKeyboard = false,
  });

  final Widget body;
  final bool withDismissKeyboard;

  @override
  Widget build(BuildContext context) {
    if (withDismissKeyboard == true) {
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus != null
            ? FocusManager.instance.primaryFocus.unfocus()
            : null,
        child: body,
      );
    }
    return body;
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key key,
    this.body,
    this.header,
    this.contentBackgroundColor,
    this.safeAreaTop,
    this.safeAreaBottom,
    this.safeAreaLeft,
    this.safeAreaRight,
  }) : super(key: key);

  final ScreenHeader header;
  final Widget body;
  final Color contentBackgroundColor;
  final bool safeAreaTop;
  final bool safeAreaBottom;
  final bool safeAreaLeft;
  final bool safeAreaRight;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: safeAreaTop ?? true,
      left: safeAreaLeft ?? true,
      right: safeAreaRight ?? true,
      bottom: safeAreaBottom ?? true,
      child: Column(
        children: [
          if (header != null) header,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: contentBackgroundColor ??
                    const Color.fromRGBO(245, 245, 245, 1.0),
              ),
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    Key key,
    @required Widget body,
  })  : _body = body,
        super(key: key);

  ScreenHeader.only({
    Key key,
    bool withText,
    bool withSwitch,
    bool withBackgroundImage,
    bool withProfile,
    String text,
    DecorationImage backgroundImage,
    ImageProvider profileImage,
  })  : _body = _ScreenHeader(
          text: text ?? "",
          backgroundImage: backgroundImage,
          profileImage: profileImage,
          withText: withText ?? false,
          withSwitch: withSwitch ?? false,
          withBackgroundImage: withBackgroundImage ?? false,
          withProfile: withProfile ?? false,
        ),
        super(key: key);

  factory ScreenHeader.text(
    String text, {
    Key key,
    DecorationImage backgroundImage,
    ImageProvider profileImage,
  }) {
    return ScreenHeader.only(
      key: key,
      text: text,
      backgroundImage: backgroundImage,
      profileImage: profileImage,
      withText: true,
      withBackgroundImage: true,
      withProfile: true,
      withSwitch: true,
    );
  }

  final Widget _body;

  @override
  Widget build(BuildContext context) {
    return _body;
  }
}

class _ScreenHeader extends StatelessWidget {
  const _ScreenHeader({
    String text,
    this.backgroundImage,
    this.profileImage,
    this.withText,
    this.withBackgroundImage,
    this.withSwitch,
    this.withProfile,
  }) : _text = text ?? "";

  final String _text;
  final DecorationImage backgroundImage;
  final ImageProvider profileImage;
  final bool withText;
  final bool withBackgroundImage;
  final bool withSwitch;
  final bool withProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      width: MediaQuery.of(context).size.width,
      height: 100,
      padding:
          const EdgeInsets.symmetric(horizontal: 15.0).copyWith(bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        image: withBackgroundImage == true
            ? (backgroundImage ??
                const DecorationImage(
                  image: AssetImage("assets/images/header_mountains.png"),
                  fit: BoxFit.cover,
                ))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (withText == true)
            DefaultText(
              _text,
              textLevel: TextLevel.h1,
              color: Colors.white,
            ),
          if (withProfile == true || withSwitch == true)
            BlocProvider(
              create: (_) => HeaderCubit(),
              child: Expanded(
                child: _ProfileSwitch(
                  withProfile: withProfile,
                  withSwitch: withSwitch,
                  profileImage: profileImage,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ProfileSwitch extends StatelessWidget {
  const _ProfileSwitch({
    Key key,
    this.withSwitch,
    this.withProfile,
    this.profileImage,
  }) : super(key: key);

  final bool withSwitch;
  final bool withProfile;
  final ImageProvider profileImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (withSwitch == true)
          BlocBuilder<FavoritesBloc, FavoritesState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              return Switch(
                // value == false means enabled
                value: state.status != FavoritesStatus.enabled,
                onChanged: (newValue) {
                  if (newValue == false) {
                    context.read<FavoritesBloc>().add(EnableFavorites());
                  } else {
                    context.read<FavoritesBloc>().add(DisableFavorites());
                  }
                },
                activeColor: Colors.white,
                // inactiveTrackColor: Colors.white,
                activeThumbImage: const ResizeImage(
                  AssetImage("assets/icons/favorites_off.png"),
                  width: 13,
                  height: 13,
                ),
                inactiveThumbImage: const ResizeImage(
                  AssetImage("assets/icons/favorites.png"),
                  width: 13,
                  height: 13,
                ),
              );
            },
          ),
        if (withProfile == true)
          GestureDetector(
            onTap: () {
              // TODO -- insert navigating to profile page
            },
            child: Padding(
              padding: withSwitch == false
                  ? const EdgeInsets.only(bottom: 9.0)
                  : EdgeInsets.zero,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 15.0,
                backgroundImage: profileImage,
              ),
            ),
          ),
      ],
    );
  }
}
