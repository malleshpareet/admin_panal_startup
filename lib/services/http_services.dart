import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:get/get.dart';
import '../utility/constants.dart';

class HttpService {
  final String baseUrl = MAIN_URL;

  Future<Response> getItems({required String endpointUrl}) async {
    try {
      final response = await GetConnect().get('$baseUrl/$endpointUrl');
      return response;
    } catch (e) {
      print('Error in getItems: $e');
      return Response(body: {'error': e.toString()}, statusCode: 500);
    }
  }

  Future<Response> addItem(
      {required String endpointUrl, required dynamic itemData}) async {
    try {
      final response =
          await GetConnect().post('$baseUrl/$endpointUrl', itemData);
      print(response.body);
      return response;
    } catch (e) {
      print('Error in addItem: $e');
      return Response(body: {'message': e.toString()}, statusCode: 500);
    }
  }

  Future<Response> updateItem(
      {required String endpointUrl,
      required String itemId,
      required dynamic itemData}) async {
    try {
      final response =
          await GetConnect().put('$baseUrl/$endpointUrl/$itemId', itemData);
      return response;
    } catch (e) {
      print('Error in updateItem: $e');
      return Response(body: {'message': e.toString()}, statusCode: 500);
    }
  }

  Future<Response> deleteItem(
      {required String endpointUrl, required String itemId}) async {
    try {
      final response =
          await GetConnect().delete('$baseUrl/$endpointUrl/$itemId');
      return response;
    } catch (e) {
      print('Error in deleteItem: $e');
      return Response(body: {'message': e.toString()}, statusCode: 500);
    }
  }
}
