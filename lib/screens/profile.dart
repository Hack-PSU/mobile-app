

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackpsu/cubit/profile_cubit.dart';
import 'package:hackpsu/models/email.dart';
import 'package:hackpsu/widgets/button.dart';
import 'package:hackpsu/widgets/input.dart';
import '../widgets/default_text.dart';
import '../data/authentication_repository.dart';

import '../cubit/profile_cubit.dart';
import '../models/profile_model.dart';
import '../widgets/screen.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Screen(
        body: BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(context.read<AuthenticationRepository>()),
          child: const ProfileScreen(),
        )
    );
  }
}
  class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 100,
          child: _appBar()
          )
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 150,
            width: 150,
            margin: const EdgeInsets.only(top: 125.0),
            child: _avatar()
          )
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
          margin: const EdgeInsets.only(top: 275.0),
            child: _changeAvatarButton()
          )
        ),
        Align(child: Container(
          child: _EmailGetter(),
          )
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 200,
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              'assets/images/mountain.svg',
              alignment: Alignment.bottomCenter,
            ),
          )
        )
      ]
    );
  }
}
  Widget _appBar() {
    final appBarHeight = AppBar().preferredSize.height;
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
        return AppBar(
          backgroundColor: const Color(0xFF113654),
          title: DefaultText(
                  "Profile",
                  textLevel: TextLevel.h2,
                  color: const Color(0xFFF4603D),
                ),
          actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  context.read<AuthenticationRepository>().signOut();
                },
              ),
          ],
        );
      }),
    );
  }


  Widget _avatar() {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      return CircleAvatar(
        radius: 50,
        backgroundColor: const Color(0xFF113654),
        child: Icon(Icons.person),
      );
    });
  }

  Widget _changeAvatarButton() {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      return TextButton(
        onPressed: () {},
        child: Text('Change Avatar'),
      );
    });
  }


    Widget _saveProfileChangesButton() {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      return ElevatedButton(
        onPressed: () {},
        child: Text('Save Changes'),
      );
    });
  }



class _EmailGetter extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
      
      return Center (child: Text(state.email != null ? state.email.value : ""),);
      }
    );
  } 
}

