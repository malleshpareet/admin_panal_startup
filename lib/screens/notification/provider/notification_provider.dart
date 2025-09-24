import 'dart:developer';

import 'package:get/get_connect/http/src/response/response.dart';

import '../../../models/api_response.dart';
import '../../../models/my_notification.dart';
import '../../../models/notification_result.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/data/data_provider.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';

class NotificationProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final sendNotificationFormKey = GlobalKey<FormState>();

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController imageUrlCtrl = TextEditingController();

  NotificationResult? notificationResult;

  NotificationProvider(this._dataProvider);

  sendNotification() async {
    try {
      // Validate required fields
      if (titleCtrl.text.isEmpty || descriptionCtrl.text.isEmpty) {
        SnackBarHelper.showErrorSnackBar('Title and description are required');
        return;
      }

      Map<String, dynamic> notification = {
        "title": titleCtrl.text,
        "description": descriptionCtrl.text,
        "imageUrl": imageUrlCtrl.text
      };

      final response = await service.addItem(
          endpointUrl: 'notification/send-notification',
          itemData: notification);

      // Check if response exists and is successful
      if (response != null && response.isOk) {
        try {
          // Try to parse as ApiResponse
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if (apiResponse.success == true) {
            clearFields();
            SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
            log('Notification send');
            _dataProvider.getAllNotifications();
          } else {
            // Handle API-level errors
            SnackBarHelper.showErrorSnackBar(
                'Failed to send Notification: ${apiResponse.message}');
          }
        } catch (parseError) {
          // Handle cases where response is not in expected ApiResponse format
          print('Error parsing response: $parseError');
          print('Response body: ${response.body}');

          // Check if it's a direct success response (like the one you showed)
          if (response.body is Map<String, dynamic>) {
            Map<String, dynamic> body = response.body;
            if (body['success'] == true) {
              clearFields();
              String message =
                  body['message'] ?? 'Notification sent successfully';
              SnackBarHelper.showSuccessSnackBar(message);
              log('Notification send');
              _dataProvider.getAllNotifications();
              return;
            } else if (body['success'] == false) {
              String message = body['message'] ?? 'Failed to send notification';
              SnackBarHelper.showErrorSnackBar(message);
              return;
            }
          }

          SnackBarHelper.showErrorSnackBar('Failed to parse server response');
        }
      } else {
        // Handle HTTP-level errors
        String errorMessage = 'Unknown error occurred';
        if (response != null) {
          if (response.body is Map<String, dynamic>) {
            Map<String, dynamic> body = response.body;
            errorMessage = body['message'] ??
                body['error'] ??
                response.statusText ??
                errorMessage;
          } else {
            errorMessage = response.body?.toString() ??
                response.statusText ??
                errorMessage;
          }
        }
        SnackBarHelper.showErrorSnackBar('Error: $errorMessage');
      }
    } catch (e) {
      print('Exception in sendNotification: $e');
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
    }
  }

  deleteNotification(MyNotification notification) async {
    try {
      Response response = await service.deleteItem(
          endpointUrl: 'notification/delete-notification',
          itemId: notification.sId ?? '');

      if (response != null && response.isOk) {
        try {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if (apiResponse.success == true) {
            SnackBarHelper.showSuccessSnackBar(
                'Notification Deleted Successfully');
            _dataProvider.getAllNotifications();
          } else {
            SnackBarHelper.showErrorSnackBar('Error: ${apiResponse.message}');
          }
        } catch (parseError) {
          print('Error parsing delete response: $parseError');
          SnackBarHelper.showErrorSnackBar('Failed to parse server response');
        }
      } else {
        String errorMessage = 'Unknown error';
        if (response != null) {
          errorMessage = response.body?.toString() ??
              response.statusText ??
              'Unknown error';
        }
        SnackBarHelper.showErrorSnackBar('Error: $errorMessage');
      }
    } catch (e) {
      print('Exception in deleteNotification: $e');
      SnackBarHelper.showErrorSnackBar(
          'An error occurred while deleting notification: $e');
    }
  }

  getNotificationInfo(MyNotification? notification) async {
    try {
      if (notification == null) {
        SnackBarHelper.showErrorSnackBar('Something went wrong');
        return 'Something went wrong';
      }

      final response = await service.getItems(
          endpointUrl:
              'notification/track-notification/${notification.notificationId}');

      if (response != null && response.isOk) {
        try {
          final ApiResponse<NotificationResult> apiResponse =
              ApiResponse<NotificationResult>.fromJson(
                  response.body,
                  (json) => NotificationResult.fromJson(
                      json as Map<String, dynamic>));

          if (apiResponse.success == true) {
            NotificationResult? myNotificationResult = apiResponse.data;
            notificationResult = myNotificationResult;
            print(notificationResult?.platform);
            log('notification fetch success');
            notifyListeners();
            return null;
          } else {
            SnackBarHelper.showErrorSnackBar(
                'Failed to Fetch Data: ${apiResponse.message}');
            return 'Failed to Fetch Data: ${apiResponse.message}';
          }
        } catch (parseError) {
          print('Error parsing notification info response: $parseError');
          SnackBarHelper.showErrorSnackBar('Failed to parse server response');
          return 'Failed to parse server response';
        }
      } else {
        String errorMessage = 'Unknown error';
        if (response != null) {
          errorMessage = response.body?.toString() ??
              response.statusText ??
              'Unknown error';
        }
        SnackBarHelper.showErrorSnackBar('Error: $errorMessage');
        return 'Error: $errorMessage';
      }
    } catch (e) {
      print('Exception in getNotificationInfo: $e');
      SnackBarHelper.showErrorSnackBar(
          'An error occurred while fetching notification info: $e');
      return 'An error occurred: $e';
    }
  }

  clearFields() {
    titleCtrl.clear();
    descriptionCtrl.clear();
    imageUrlCtrl.clear();
  }

  updateUI() {
    notifyListeners();
  }
}
