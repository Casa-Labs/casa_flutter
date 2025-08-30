// ignore: avoid_classes_with_only_static_members
class RazorpayConst {
  static const String devKeyId = 'rzp_test_RB9OPGcldAh1Ul';

  // static const String liveKeyId = 'rzp_live_1nzkHh8TnNLlwJ';
  static const String liveKeyId = 'rzp_live_NSJ391QbwVovIS';

  /// Razorpay Key ID based on the environment
  /// Will use [_liveKeyId] for Live flavor else [_devKeyId] for Stage
  /// and Dev flavors
  //static String get keyId => ApiConstants.isLive ? liveKeyId : _devKeyId;
}
