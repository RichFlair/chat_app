import 'dart:async';
import 'package:flutter/services.dart';

class NotificationService {
  static const MethodChannel _channel =
      MethodChannel('com.example.my_app/notification_service');

  NotificationService() {
    _channel.setMethodCallHandler(_methodCallHandler);
  }

  Future<String?> initialize() async {
    return await _channel.invokeMethod('initialize');
  }

  Future<void> requestPermissions() async {
    return await _channel.invokeMethod('requestPermissions');
  }

  Future<void> configureSelectNotificationSubject(String subject) async {
    return await _channel
        .invokeMethod('configureSelectNotificationSubject', <String, dynamic>{
      'subject': subject,
    });
  }

  Future<dynamic> _methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'selectNotification':
        final String? subject = call.arguments['subject'];
        // Handle the notification
        print(subject);
        break;
      default:
        throw PlatformException(
            code: 'Unimplemented',
            details:
                'NotificationService does not implement method ${call.method}');
    }
  }
}
