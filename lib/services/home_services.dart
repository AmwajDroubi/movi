import 'package:dio/dio.dart';
import 'package:movi/model/top_headline_model.dart';
import 'package:movi/utils/app_constant.dart';

class HomeServices {
  // استخدام Dio لأنه يساعد في إجراء الطلبات إلى الخوادم
  final aDio = Dio();

  // دالة لإحضار العناوين الرئيسية
  Future<MovieResponse> getTopHeadlines(MovieResponse queryParams) async {
    try {
      final headers = {
        'Authorization': "Bearer ${AppConstants.moviApiKey}",
      };
      final result = await aDio.get(
        '${AppConstants.baseUrl}', // تأكد من أن هذا الـ URL صحيح
        options: Options(headers: headers),
        queryParameters: queryParams.toMap(), // تمرير المعاملات الصحيحة من MoviModel
      );

      if (result.statusCode == 200) {
        // إذا كانت الاستجابة صحيحة، تحويل البيانات إلى MovieResponse
        return MovieResponse.fromMap(result.data);
      } else {
        // في حال فشل الاستجابة
        throw Exception('فشل تحميل بيانات الأفلام من الخادم');
      }
    } catch (e) {
      // إعادة رمي الاستثناء في حال حدوث خطأ
      rethrow;
    }
  }
}
