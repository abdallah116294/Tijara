import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tijara/core/shared/cache_helper.dart';
import 'package:tijara/models/payment_request_model.dart';
import '../constent/app_constant.dart';
import '../core/network/dio_helper.dart';
import '../models/authentication_request_model.dart';
import '../models/oreder_registeration_model.dart';

class PaymentProvider with ChangeNotifier {
  AuthenticationRequestModel? authenticationRequestModel;
  OrderRegisterationModel? orderRegisterationModel;
  PaymentRequsetModel? paymentRequsetModel;
  Future<void> getAuthToken() async {
    try {
      await DioHelper.postData(
          url: AppConstant.getAuthToken,
          data: {"api_key": AppConstant.paymentAPIkey}).then((value) {
        AppConstant.paymentFirstToken = value.data['token'];
        authenticationRequestModel =
            AuthenticationRequestModel.formJson(value.data);
        AppConstant.paymentFirstToken = authenticationRequestModel!.token;
      });
    } catch (error) {
      log("auth error occured$error");
    }
  }

  Future getOrderRegistrationId({
    required String fname,
    required String lname,
    required String email,
    required String phone,
    required String price,
  }) async {
    try {
      await DioHelper.postData(url: AppConstant.getOrderId, data: {
        "auth_token": CacheHelper.getData(key: "payment_first_token"),
        "delivery_needed": "true",
        "amount_cents": price,
        "currency": "EGP",
        "items": [],
      }).then((value) {
        AppConstant.paymentOrderId = value.data["id"];
        orderRegisterationModel = OrderRegisterationModel.fromJson(value.data);
        AppConstant.paymentOrderId =
            orderRegisterationModel!.id.toString() as String;
        getPaymentRequest(
            email: email,
            fname: fname,
            lname: lname,
            phone: phone,
            price: price);
      });
    } catch (error) {
      log("get orderID error $error");
    }
  }

  Future<void> getPaymentRequest({
    required String fname,
    required String lname,
    required String email,
    required String phone,
    required String price,
  }) async {
    try {
      await DioHelper.postData(url: AppConstant.paymentKeyRequeset, data: {
        "auth_token": AppConstant.paymentFirstToken,
        "amount_cents": price,
        "expiration": 3600,
        "order_id": AppConstant.paymentOrderId,
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": fname,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "last_name": lname,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": AppConstant.paymentIntegrationCardId,
        "lock_order_when_paid": "false"
      }).then((value) {
        AppConstant.finalToken = value.data["token"];
        paymentRequsetModel = PaymentRequsetModel.fromJson(value.data);
        AppConstant.finalToken = paymentRequsetModel!.token;
      });
    } catch (error) {
      log("error occured in payment Request  $error");
    }
  }

  Future<void> getRefCode() async {
    try {
      DioHelper.postData(url: AppConstant.getRefCode, data: {
        "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
        "payment_token": AppConstant.finalToken
      }).then((value) {
        AppConstant.refCode = value.data["id"].toString();
      });
    } catch (error) {
      log("Kisok Payment errror$error");
    }
  }
}
