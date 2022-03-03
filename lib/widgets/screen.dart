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
    @required String header,
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
    String header,
  })  : _header = header,
        _body = body,
        super(key: key);

  final String _header;
  final Widget _body;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _ScreenHeader(_header),
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

class _ScreenHeader extends StatelessWidget {
  const _ScreenHeader(String text) : _text = text;

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/images/header_bg_clipped-min.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: DefaultText(
                _text,
                textLevel: TextLevel.h1,
                color: Colors.white,
              ),
            ),
          ),
          BlocProvider(
            create: (_) => HeaderCubit(),
            child: const Expanded(
              child: _ProfileSwitch(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileSwitch extends StatelessWidget {
  const _ProfileSwitch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
        const CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 15.0,
        ),
      ],
    );
  }
}
