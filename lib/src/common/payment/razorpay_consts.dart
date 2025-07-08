// ignore: avoid_classes_with_only_static_members
class RazorpayConst {
  static const String devKeyId = 'rzp_test_fFvljonXlvK2BG';

  // static const String liveKeyId = 'rzp_live_1nzkHh8TnNLlwJ';
  static const String liveKeyId = 'rzp_live_4X2os1YWsXRGrn';

  /// Razorpay Key ID based on the environment
  /// Will use [_liveKeyId] for Live flavor else [_devKeyId] for Stage
  /// and Dev flavors
  //static String get keyId => ApiConstants.isLive ? liveKeyId : _devKeyId;
}
