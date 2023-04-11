import 'package:network_bound_resource/network_bound_resource.dart';

import './http_provider_interface.dart';
import '../interceptors/interceptor.dart';

class HttpProviderImpl extends HttpProviderInterface {
  late NetworkBoundResource _httpClient;
  final String baseUrl;

  HttpProviderImpl(this.baseUrl) {
    _httpClient = NetworkBoundResource(
      baseUrl,
      interceptors: [AppInterceptors()],
    );
  }

  @override
  NetworkBoundResource instance() => _httpClient;
}
