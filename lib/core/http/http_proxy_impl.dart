import 'package:network_bound_resource/network_bound_resource.dart';

import './interceptors/interceptor.dart';
import './repositories/http_proxy_interface.dart';

class HttpProxyImpl extends HttpProxyInterface {

  HttpProxyImpl(this.baseUrl) {
    _httpClient = NetworkBoundResource(
      baseUrl,
      interceptors: [AppInterceptors()],
    );
  }

  late NetworkBoundResource _httpClient;
  final String baseUrl;

  @override
  NetworkBoundResource instance() => _httpClient;
}
