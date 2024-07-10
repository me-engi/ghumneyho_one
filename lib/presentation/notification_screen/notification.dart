import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toursandtravels/constants/const_colors.dart';
import 'package:toursandtravels/presentation/notification_screen/notification_controller/notification_controller.dart';

import '../../constants/custom_textstyle.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var notificationController = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ConstColors.textColor,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Notifications",
          style: getTextTheme().headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => notificationController.isnotificationLoading.value
              ? SizedBox(
                  height: Get.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ConstColors.primaryColor,
                    ),
                  ),
                )
              : notificationController.notificationList!.isEmpty
                  ? SizedBox(
                      height: Get.height,
                      child: Center(
                        child: Text(
                          "No Notification",
                          style: getTextTheme().headlineMedium,
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      reverse: true,
                      shrinkWrap: true,
                      itemCount:
                          notificationController.notificationList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          height: Get.height * .25,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: ConstColors.backgroundColor,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20,
                                  color: Colors.black.withOpacity(.1),
                                )
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  child: Image.network(
                                      width: Get.width,
                                      fit: BoxFit.fill,
                                      'https://img.freepik.com/free-photo/travel-concept-with-landmarks_23-2149153256.jpg'),
                                ),
                              ),
                              ListTile(
                                onTap: () async => {},
                                title: Text(
                                  notificationController
                                      .notificationList![index]["title"],
                                  style: getTextTheme().headlineMedium,
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notificationController
                                              .notificationList![index]
                                          ["description"],
                                      style: getTextTheme().headlineSmall,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            DateFormat().format(DateTime.parse(
                                                notificationController
                                                        .notificationList![
                                                    index]["created_at"])),
                                            style: getTextTheme()
                                                .headlineSmall!
                                                .copyWith(fontSize: 50.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
