import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../config/flavor_constants.dart';

class SocketData {
  SocketData({
    required this.event,
    this.data,
  });

  final String event;
  dynamic data;
}

class SocketManager {
  static final _instance = SocketManager();
  final BehaviorSubject<SocketData> _socketResponse = BehaviorSubject();
  io.Socket? _socket;
  bool isConnected = false;

  Stream<SocketData> get socket => _socketResponse.stream;

  static SocketManager get instance => _instance;

  // Initialized in AuthBloc after user is successfully authenticated
  Future<void> connect() async {
    if (FirebaseAuth.instance.currentUser != null && _socket == null) {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      _socket = io.io(
        Config.wsUrl,
        <String, dynamic>{
          "transports": ["websocket"],
          "autoConnect": false,
          "extraHeaders": {"idtoken": token},
        },
      );

      _socket?.connect();

      _socket?.onConnectError((data) {
        if (kDebugMode) {
          print("ConnectError: $data");
        }
      });
      _socket?.onError((data) {
        if (kDebugMode) {
          print("Error: $data");
        }
      });
      _socket?.onDisconnect((data) {
        if (kDebugMode) {
          print("LOG [WS]: Disconnecting");
        }
      });

      _socket?.onConnect((_) {
        isConnected = true;
        _socket?.emit("ping:mobile");

        if (kDebugMode) {
          print("LOG [WS]: Connected");
        }
      });

      _socket?.on(
        "update:event",
        (data) => _socketResponse.add(
          SocketData(
            event: "update:event",
            data: data,
          ),
        ),
      );

      _socket?.on(
        "update:hackathon",
        (data) => _socketResponse.add(
          SocketData(
            event: "update:hackathon",
            data: data,
          ),
        ),
      );

      _socket?.on(
        "update:sponsorship",
        (data) => _socketResponse.add(
          SocketData(
            event: "update:sponsorship",
            data: data,
          ),
        ),
      );

      _socket?.on(
        "update:extraCredit",
        (data) => _socketResponse.add(
          SocketData(
            event: "update:extraCredit",
            data: data,
          ),
        ),
      );
    }
  }

  void dispose() {
    _socket?.dispose();
    _socket = null;
  }
}
