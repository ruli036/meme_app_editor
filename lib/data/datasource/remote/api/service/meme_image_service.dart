import 'package:meme_editor_app/core/network/base_api_response.dart';
import 'package:meme_editor_app/data/datasource/dto/response_meme_model.dart';
import 'package:meme_editor_app/data/datasource/remote/api/endpoint/meme_images_end_point.dart';
import 'package:meme_editor_app/data/datasource/remote/handler/handler_restfull_api.dart';
import 'package:meme_editor_app/data/datasource/remote/handler/http_helper.dart';
import 'package:http/http.dart' as http;
import 'package:meme_editor_app/domain/service/meme_image_service.dart';

class MemeImageServiceDataSourceImpl implements MemeImageServiceDataSource{
  final APIHandler _apiHandler = APIHandler();
  final HttpHelper _httpHelper = HttpHelper();
  final _apiClient = http.Client();

  @override
  Future<BaseApiResponse<MemeImage>> getMemeImages() async {
    return _apiHandler.performApiRequest<MemeImage>(
      request: () => _httpHelper.getAPI(
        client: _apiClient,
        uri: MemeImagesEndPoint.getMemeImage(),
      ),
      fromJson: (json) {
        return MemeImage.fromJson(json);
      },
    );
  }
}
