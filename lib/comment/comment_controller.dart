import 'package:get/get.dart';
import 'package:toursandtravels/comment/comment_model.dart';
import 'package:toursandtravels/comment/comment_repo.dart';


class CommentController extends GetxController {
  final CommentRepo _commentRepo = CommentRepo();

  var comments = <Commentget>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchComments();
  }

  Future<void> fetchComments() async {
    isLoading(true);
    try {
      var response = await _commentRepo.getcommnetsTour();
      comments.value = (response as List)
          .map((comment) => Commentget.fromJson(comment))
          .toList();
    } catch (e) {
      print("Error fetching comments: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> postComment({
    required String tourId,
    required String user,
    required int userId,
    required String tourName,
    int? rating,
    String? comment,
  }) async {
    isLoading(true);
    try {
      await _commentRepo.postcommentTour(
        tourId: tourId,
        user: user,
        userId: userId,
        tourName: tourName,
        rating: rating,
        comment: comment,
      );
      fetchComments(); // Refresh comments after posting a new one
    } catch (e) {
      print("Error posting comment: $e");
    } finally {
      isLoading(false);
    }
  }
}
