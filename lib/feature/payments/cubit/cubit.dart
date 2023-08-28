
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tijara/feature/payments/cubit/state.dart';
import '../../../constent/app_constant.dart';
import '../../../core/network/dio_helper.dart';
import '../../../models/authentication_request_model.dart';
import '../../../models/oreder_registeration_model.dart';
import '../../../models/payment_request_model.dart';

class PaymentCubit extends Cubit<PaymentInitialStates> {
  //PaymentCubit(super.initialState);
  PaymentCubit() : super(PaymentInitialStates());
  static PaymentCubit get(context) => BlocProvider.of(context);
  AuthenticationRequestModel? authenticationRequestModel;
  OrderRegisterationModel? orderRegisterationModel;
  PaymentRequsetModel? paymentRequsetModel;
  Future<void> getAuthToken() async {
    emit(PaymentAuthLoadingStates());
    await DioHelper.postData(
        url: AppConstant.getAuthToken,
        data: {"api_key": AppConstant.paymentAPIkey}).then((value) {
      AppConstant.paymentFirstToken = value.data['token'];
      // authenticationRequestModel =
      //     AuthenticationRequestModel.formJson(value.data);
      // AppConstant.paymentFirstToken = authenticationRequestModel!.token;
      emit(PaymentAuthSuccessStates());
    }).catchError((onError) {
      print("Error in Auth token ${onError.toString()}");
      emit(PaymentAuthErrorStates(onError.toString()));
    });
  }

  Future getOrderRegistrationId({
    required String fname,
    required String lname,
    required String email,
    required String phone,
    required String price,
  }) async {
    emit(PaymentOrderIdLoadingStates());
    await DioHelper.postData(url: AppConstant.getOrderId, data: {
      "auth_token": AppConstant.paymentFirstToken,
      "delivery_needed": "false",
      "amount_cents": price,
      "currency": "EGP",
      "items": [],
    }).then((value) {
      AppConstant.paymentOrderId = value.data["id"].toString();
      // orderRegisterationModel = OrderRegisterationModel.fromJson(value.data);
      // AppConstant.paymentOrderId =
      //     orderRegisterationModel!.id.toString() as int;
     getPaymentRequest(
            email: email,
            fname: fname,
            lname: lname,
            phone: phone,
            price: price);
      emit(PaymentOrderIdSuccessStates());
    }).catchError((error) {
      print("Error in order id ${error.toString()}");
      emit(PaymentOrderIdErrorStates(error.toString()));
    });
  }

  Future<void> getPaymentRequest({
    required String fname,
    required String lname,
    required String email,
    required String phone,
    required String price,
  }) async {
    emit(PaymentRequestTokenLoadingStates());
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
      // paymentRequsetModel = PaymentRequsetModel.fromJson(value.data);
      // AppConstant.finalToken = paymentRequsetModel!.token;
      emit(PaymentRequestTokenSuccessStates());
    }).catchError((error) {
      print("error in request token ${error.toString()}");
      emit(PaymentRequestTokenErrorStates(error.toString()));
    });
  }

  Future<void> getRefCode() async {
    emit(PaymentRefCodeLoadingStates());
    DioHelper.postData(url: AppConstant.getRefCode, data: {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token": AppConstant.finalToken
    }).then((value) {
      AppConstant.refCode = value.data["id"].toString();
      emit(PaymentRefCodeSuccessStates());
    }).catchError((error) {
      print("error in get refcode ${error.toString()}");
      emit(PaymentRefCodeErrorStates(error.toString()));
    });
  }
}
