import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/navigation/bottom_navigation_state.dart';
import '../cubit/header_cubit.dart';
import 'bottom_navigation.dart';
import 'default_text.dart';

class Screen extends Scaffold {
  Screen({
    Key key,
    AppBar appBar,
    Color backgroundColor,
    this.withBottomNavigation = false,
    this.withDismissKeyboard = false,
    this.onNavigationRouteChange,
    @required Widget body,
  }) : super(
          key: key,
          backgroundColor:
              backgroundColor ?? const Color.fromRGBO(224, 224, 224, 1.0),
          appBar: appBar,
          body: _Page(
            body,
            withDismissKeyboard: withDismissKeyboard,
            withBottomNavigation: withBottomNavigation,
          ),
          bottomNavigationBar:
              withBottomNavigation ? const BottomNavigation() : null,
        );

  Screen.withHeader({
    Key key,
    AppBar appBar,
    Color backgroundColor,
    @required Widget body,
    @required bool withBottomNavigation,
    @required ScreenHeader header,
    bool withDismissKeyboard,
  }) : this(
          key: key,
          appBar: appBar,
          backgroundColor: backgroundColor ?? Colors.white,
          withBottomNavigation: withBottomNavigation,
          withDismissKeyboard: withDismissKeyboard,
          body: _Page(
            _Header(
              body: body,
              header: header,
            ),
            withBottomNavigation: withBottomNavigation,
            withDismissKeyboard: withDismissKeyboard,
          ),
        );

  final bool withBottomNavigation;
  final bool withDismissKeyboard;
  final Function(Routes) onNavigationRouteChange;
}

class _Page extends StatelessWidget {
  const _Page(
    this.body, {
    this.withDismissKeyboard = false,
    this.withBottomNavigation = false,
  });

  final Widget body;
  final bool withDismissKeyboard;
  final bool withBottomNavigation;

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

class _Header extends StatelessWidget {
  const _Header({
    Key key,
    Widget body,
    ScreenHeader header,
  })  : _header = header,
        _body = body,
        super(key: key);

  final ScreenHeader _header;
  final Widget _body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _header,
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(224, 224, 224, 1.0),
              ),
              child: _body,
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
          withText: text != null || withText == true,
          withSwitch: withSwitch ?? false,
          withBackgroundImage:
              backgroundImage != null || withBackgroundImage == true,
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
      decoration: BoxDecoration(
        color: Colors.white,
        image: withBackgroundImage == true
            ? (backgroundImage ??
                const DecorationImage(
                  image: AssetImage("assets/images/header_bg_clipped-min.png"),
                  fit: BoxFit.cover,
                ))
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: withText
                ? Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: DefaultText(
                      _text,
                      textLevel: TextLevel.h1,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
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
      children: [
        if (withSwitch == true)
          BlocBuilder<HeaderCubit, bool>(
            buildWhen: (oldState, newState) => oldState != newState,
            builder: (context, state) => Switch(
              value: state,
              onChanged: (newValue) {
                context.read<HeaderCubit>().toggleSwitch(newValue);
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
            ),
          ),
        if (withProfile == true)
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 15.0,
            backgroundImage: profileImage,
          ),
      ],
    );
  }
}
