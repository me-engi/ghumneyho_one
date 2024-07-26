import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:toursandtravels/constants/const_colors.dart';
import 'package:toursandtravels/presentation/payment_screen/payment_model.dart';
import 'package:toursandtravels/presentation/payment_screen/payment_repo/payment_repo.dart';

class PaymentController extends GetxController {
  var isLoading = false.obs;
  List? bookingPersonsDetailsData;
  final PaymentRepo apiCall = PaymentRepo();

  Future<void> getDatapersonDetails() async {
    isLoading.value = true;
    try {
      bookingPersonsDetailsData = await apiCall.getBookingPersonDetails();
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getDatapersonDetails();
    super.onInit();
  }
}

class FetchPaymentController extends GetxController {
  var finalPayment = Finalpayment(
    initialPrice: "0.00",
    discount: "0.00",
    additionalCharges: "0.00",
    finalPrice: "0.00"
  ).obs;
  var isLoading = false.obs;
  final PaymentRepo apiCall = PaymentRepo(); // Instantiate your repository

  // Fetch final price method
  Future<void> fetchFinalPrice(String tourId, {String? coupon}) async {
    try {
      isLoading(true);
      final result = await apiCall.getFinalPrice(tourId, coupon: coupon);
      finalPayment.value = result;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error fetching price details",
          backgroundColor: ConstColors.primaryColor,
          toastLength: Toast.LENGTH_SHORT);
    } finally {
      isLoading(false);
    }
  }
}
