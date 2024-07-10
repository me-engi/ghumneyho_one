import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toursandtravels/presentation/notification_screen/notification_repo.dart/notification_repo.dart';

class NotificationController extends GetxController {
  List? notificationList;
  RxBool isnotificationLoading = false.obs;
  NotificationRepo api = NotificationRepo();

  getNotificationData() async {
    isnotificationLoading.value = true;
    notificationList = await api.getNotification();
    isnotificationLoading.value = false;
  }

  @override
  void onInit() {
    getNotificationData();
    super.onInit();
  }
}
