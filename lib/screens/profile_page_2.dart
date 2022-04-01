// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../cubit/profile_cubit.dart';
// import '../data/authentication_repository.dart';
// import '../models/profile_state.dart';
// import '../widgets/default_text.dart';
// import '../widgets/screen.dart';
//
// class ProfilePage2 extends StatelessWidget {
//   const ProfilePage2({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Screen(
//       body: BlocProvider<ProfileCubit>(
//         create: (context) => ProfileCubit(
//           context.read<AuthenticationRepository>(),
//         ),
//         child: const ProfileScreen(),
//       ),
//     );
//   }
// }
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key key}) : super(key: key);
//
//   static const IconData chevron_left =
//       IconData(0xe15e, fontFamily: 'MaterialIcons', matchTextDirection: true);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.topCenter,
//       children: [
//         AspectRatio(
//           aspectRatio: 487 / 475,
//           child: Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.fitWidth,
//                 alignment: FractionalOffset.topCenter,
//                 image: AssetImage('assets/images/background.jpg'),
//               ),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.topCenter,
//           child: Container(
//             height: 365,
//             color: Colors.transparent,
//             child: SvgPicture.asset(
//               'assets/images/Profile_mountain.svg',
//               width: MediaQuery.of(context).size.width,
//               fit: BoxFit.fitHeight,
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.topLeft,
//           child: Container(
//             alignment: Alignment.topLeft,
//             margin: const EdgeInsets.only(top: 50, left: 25),
//             child: _NameGetter(),
//           ),
//         ),
//         Align(
//           alignment: Alignment.topLeft,
//           child: TextButton(
//             child: Row(
//               children: const [
//                 Icon(chevron_left),
//                 Text(
//                   "BACK",
//                 ),
//               ],
//             ),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.all(Radius.circular(10.0))),
//             height: 400,
//             width: MediaQuery.of(context).size.width,
//             child: Row(
//               children: [
//                 Container(
//                   alignment: Alignment.topLeft,
//                   margin: const EdgeInsets.only(top: 25.0, left: 20),
//                   child: _avatar(),
//                 ),
//                 Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         alignment: Alignment.topRight,
//                         margin: const EdgeInsets.only(
//                             top: 25.0, right: 5, left: 30),
//                         child: _EmailGetter(),
//                       ),
//                       Container(
//                         alignment: Alignment.bottomRight,
//                         margin: const EdgeInsets.only(top: 15.0, left: 30),
//                         child: _PinGetter(),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Align(
//           child: Container(
//             alignment: Alignment.bottomCenter,
//             margin: EdgeInsets.only(bottom: 175),
//             child: DefaultText(
//               "Change Password",
//               textLevel: TextLevel.h2,
//               color: Color(0xFF113654),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: _PasswordInput(),
//         ),
//       ],
//     );
//   }
// }
//
// Widget _avatar() {
//   return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
//     return const CircleAvatar(
//       radius: 60,
//       backgroundColor: Color(0xFF113654),
//       child: Icon(Icons.person),
//     );
//   });
// }
//
// class _NameGetter extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
//       return DefaultText(
//         "Hello,\n      ${state.getName()}", //Function call from cubit NEED CHANGE
//         textLevel: TextLevel.h2,
//         color: Color(0xFFFFFFFF),
//       );
//     });
//   }
// }
//
// class _EmailGetter extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
//       return DefaultText(
//           "Email:\n   ${state.getEmail()}", //Function call from cubit NEED CHANGE
//           textLevel: TextLevel.body1,
//           color: const Color(0xFF113654));
//     });
//   }
// }
//
// class _PinGetter extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
//       return DefaultText(
//           "Pin:\n   ${state.getPin()}", //Function call from cubit NEED CHANGE
//           textLevel: TextLevel.body1,
//           color: const Color(0xFF113654));
//     });
//   }
// }
//
// class _PasswordInput extends StatelessWidget {
//   final oldPassword = TextEditingController();
//   final newPassword = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
//       return Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(bottom: 100),
//             child: TextFormField(
//               controller: oldPassword,
//               autovalidateMode: AutovalidateMode.always,
//               scrollPadding: const EdgeInsets.all(100.0),
//               decoration: const InputDecoration(
//                 icon: Icon(Icons.person),
//                 hintText: 'Password',
//                 labelText: 'Old Password *',
//               ),
//               onFieldSubmitted: (String value) {},
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 50),
//             child: TextFormField(
//               controller: newPassword,
//               autovalidateMode: AutovalidateMode.always,
//               scrollPadding: const EdgeInsets.all(100.0),
//               decoration: const InputDecoration(
//                 icon: Icon(Icons.person),
//                 hintText: 'Password',
//                 labelText: 'New Password *',
//               ),
//               onFieldSubmitted: (String value) {},
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.fromLTRB(150, 120, 3.0, 4.0),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(primary: const Color(0xFF113654)),
//               onPressed: () => context
//                   .read<ProfileCubit>()
//                   .changePassword(oldPassword.text, newPassword.text),
//               child: DefaultText('Submit',
//                   textLevel: TextLevel.h3, color: const Color(0xFFFFFFFF)),
//             ),
//           )
//         ],
//       );
//     });
//   }
// }
