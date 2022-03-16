import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthStatus { authenticated, unauthenticated, loading }

class AuthState extends Equatable {
  const AuthState._({@required this.status, this.user});

  const AuthState.verifying() : this._(status: AuthStatus.loading);

  const AuthState.authenticated(User user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
