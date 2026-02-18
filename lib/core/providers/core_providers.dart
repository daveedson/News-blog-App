import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/dio_client.dart';

final dioClientProvider = Provider<Dio>((ref) => DioClient().dio);
