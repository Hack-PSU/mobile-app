import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackpsu/cubit/header_cubit.dart';
import 'package:hackpsu/widgets/default_text.dart';
import 'bottom_navigation.dart';

class Screen extends Scaffold {
  Screen({
    AppBar appBar,
    Color backgroundColor,
    @required Widget body,
    @required this.withBottomNavigation,
    this.withDismissKeyboard,
    Key key,
  }) : super(
          key: key,
          backgroundColor:
              backgroundColor ?? const Color.fromRGBO(224, 224, 224, 1.0),
          appBar: appBar,
          body: withDismissKeyboard == true
              ? GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus != null
                      ? FocusManager.instance.primaryFocus.unfocus()
                      : null,
                  child: body,
                )
              : body,
          bottomNavigationBar: withBottomNavigation ? BottomNavigation() : null,
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
          body: _Header(
            body: body,
            header: header,
          ),
        );

  final bool withBottomNavigation;
  final bool withDismissKeyboard;
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
          image: AssetImage("assets/images/header_bg_clipped.png"),
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
