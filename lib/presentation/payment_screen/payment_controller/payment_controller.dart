import 'package:get/get.dart';
import 'package:toursandtravels/presentation/payment_screen/payment_repo/payment_repo.dart';

class PaymentController extends GetxController {
  RxBool isLoading = false.obs;
  List? bookingPersonsDetailsData;
  PaymentRepo apicall = PaymentRepo();

  Future getDatapersonDetails() async {
    isLoading.value = true;
    try {
      bookingPersonsDetailsData = await apicall.getBookingPersonDetails();
      isLoading.value = false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onInit() {
    getDatapersonDetails();
    super.onInit();
  }
}
