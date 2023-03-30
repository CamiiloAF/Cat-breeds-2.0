import 'package:network_bound_resource/network_bound_resource.dart';

import './repositories/http_proxy_interface.dart';
import './interceptors/interceptor.dart';

class HttpProxyImpl extends HttpProxyInterface {
  late NetworkBoundResource _httpClient;
  final String baseUrl;

  HttpProxyImpl(this.baseUrl) {
    _httpClient = NetworkBoundResource(
      baseUrl,
      interceptors: [AppInterceptors()],
    );
  }

  @override
  NetworkBoundResource instance() => _httpClient;
}
